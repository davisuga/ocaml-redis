open Subscribe_sync
open Subscribe_lwt

let host = ref "127.0.0.1"
let port = ref 6379

let names = [
  "subscribe_sync", (fun () -> subscribe_sync !host !port);
  "subscribe_lwt", (fun () -> subscribe_lwt !host !port);
]

let () =
  let name = ref (fst @@ List.hd names) in 
  let opts = [
    "--name", Arg.Symbol (List.map fst names, (fun s -> name := s)), " pick example to run";
    "--host", Arg.Set_string host, " host to connect to";
    "--port", Arg.Set_int port, " port to connect to";
  ] |> Arg.align in
  Arg.parse opts (fun _ -> ()) "Example of usage ocaml-redis";
  try
    let f = List.assoc !name names in
    f()
  with _ ->
    failwith @@ "no such example: " ^ !name
