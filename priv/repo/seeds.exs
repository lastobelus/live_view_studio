# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveViewStudio.Repo.insert!(%LiveViewStudio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LiveViewStudio.Repo
alias LiveViewStudio.Stores.Store

Repo.query("TRUNCATE stores", [])

%Store{
  name: "Downtown Helena",
  street: "312 Montana Avenue",
  phone_number: "406-555-0100",
  city: "Helena, MT",
  zip: "59602",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "East Helena",
  street: "227 Miner's Lane",
  phone_number: "406-555-0120",
  city: "Helena, MT",
  zip: "59602",
  open: false,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Westside Helena",
  street: "734 Lake Loop",
  phone_number: "406-555-0130",
  city: "Helena, MT",
  zip: "59602",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Downtown Denver",
  street: "426 Aspen Loop",
  phone_number: "303-555-0140",
  city: "Denver, CO",
  zip: "80204",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Midtown Denver",
  street: "7 Broncos Parkway",
  phone_number: "720-555-0150",
  city: "Denver, CO",
  zip: "80204",
  open: false,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Denver Stapleton",
  street: "965 Summit Peak",
  phone_number: "303-555-0160",
  city: "Denver, CO",
  zip: "80204",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Denver West",
  street: "501 Mountain Lane",
  phone_number: "720-555-0170",
  city: "Denver, CO",
  zip: "80204",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()
