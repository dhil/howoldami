let how_old_am_i by bm bd =
  let open Unix in
  let bm' = bm - 1 in (* Normalise to make compatible with tm_mon. *)
  let today = gmtime (time ()) in
  let age = today.tm_year - (by - 1900) in (* The subtraction normalises the birth year to make it compatible with tm_year. *)
  if today.tm_mon > bm' || (today.tm_mon = bm' && today.tm_mday >= bd)
  then age
  else age - 1

exception Bad_date_format of string
exception No_input

let parse_date dstr =
  if String.length dstr = 10
     && Char.equal '-' dstr.[4]
     && Char.equal '-' dstr.[7]
  then let year  = String.sub dstr 0 4 in
       let month = String.sub dstr 5 2 in
       let day   = String.sub dstr 8 2 in
       try
         ( int_of_string year
         , int_of_string month
         , int_of_string day )
       with Failure _ -> raise (Bad_date_format dstr)
  else raise (Bad_date_format dstr)

let get_birthday_from_environment () =
  try Some (Unix.getenv "BIRTHDAY") with
  | Not_found -> None

let _ =
  let bday = ref None in
  let usage =
    let program_name =
      Filename.basename Sys.executable_name
    in
    Printf.sprintf "usage: %s [YYYY-MM-DD]" program_name
  in
  Arg.parse [] (fun s -> bday := Some s) usage;
  try
    let (year, month, day) =
      match !bday with
      | Some date -> parse_date date
      | None ->
         match get_birthday_from_environment () with
         | None -> raise No_input
         | Some date -> parse_date date
    in
    let age = how_old_am_i year month day in
    if age < 0
    then Printf.printf "You are not born yet!\n%!"
    else Printf.printf "%d\n%!" age
  with
  | Bad_date_format _ ->
     Printf.fprintf stderr "error: date format exception.\n%!"
  | No_input ->
     print_endline usage
