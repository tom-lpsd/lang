open Http_client
open Http_client.Convenience

let _ = 
  let hm = http_head_message "http://www.google.co.jp" in 
  match hm # status with
    `Successful -> print_string "OK"
  | _ -> print_string "Error"
