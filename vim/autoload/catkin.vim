function! s:PackageCallback(job_id, data, event) abort dict
    if a:event ==# 'stdout'
        let b:catkin_package_name = a:data[0]
    elseif a:event ==# 'exit'
        if !empty(b:catkin_package_name)
            call self.on_exit_func()
            let b:catkin_initialized = 1
        else
            let b:catkin_initialized = -1
        endif
    endif
endfunction

let s:callbacks = {
\ 'on_stdout': function('s:PackageCallback'),
\ 'on_exit': function('s:PackageCallback')
\ }

function! catkin#DetectPackage(on_exit_func) abort
    if !exists('b:catkin_initialized')
        if exists('b:ros_package_path')
            call a:on_exit_func()
            let b:catkin_initialized = 1
            return
        elseif !exists('b:catkin_package_name')
            let file_dir = expand('%:h')
            if executable('catkin') && has('nvim') && isdirectory(file_dir)
                call jobstart(['catkin', 'list', '-u', '--this'],
                \   extend({
                \     'stdout_buffered': v:true,
                \     'on_exit_func': a:on_exit_func,
                \     'cwd': file_dir},
                \   s:callbacks))
            else
                let b:catkin_package_name = ''
                let b:catkin_initialized = -1
            endif
        endif
    endif
endfunction
