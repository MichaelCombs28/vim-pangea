function! pangea#redact() abort
    " Check deps
    if system('which curl') =~# 'curl not found'
        echoerr 'curl is not available, this plugin requires curl to work.'
        return
    endif

    if system('which jq') =~# 'jq not found'
        echoerr 'jq is not available, this plugin requires jq to work.'
        return
    endif

    " Check if token is set
    if !exists('g:pangea_token')
        echoerr 'API token is not set, please set g:pangea_token in your .vimrc'
        return
    endif

    let l:api_url = exists('g:pangea_url') ? g:pangea_url : 'https://redact.aws.us.pangea.cloud/v1/redact'

    " Read transformed text from the temp file
    let l:buffer_content = join(getline(1, '$'), "\n")
    let l:temp_file_path = tempname()


    " Use temp files to write payload, just easier this way
    let l:json_payload = json_encode({'text': l:buffer_content})
    call writefile([l:json_payload], l:temp_file_path)
    call system('curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer ' . g:pangea_token . '" -d @' . l:temp_file_path . ' ' . l:api_url . ' -o ' . l:temp_file_path . ' 2>&1')

    " Delete the original lines in the buffer
    silent execute '1,' . line('$') . 'delete'

    " Get text and place in current buffer
    let l:result = systemlist('jq -r .result.redacted_text ' . l:temp_file_path)
    call append(0, l:result)
    call system('rm ' . l:temp_file_path)
endfunction

