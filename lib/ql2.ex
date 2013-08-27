defmodule QL2 do
  use Protobuf, from: Path.expand("../proto/ql2.proto", __DIR__)

  extra_block "Datum" do
    Record.import __MODULE__, as: :record

    def value(record() = datum) do
      Rethinkdb.DatumHelpers.decode(datum)
    end
  end

  def global_database(database) do
    QL2.Query.AssocPair.new(key: "db", val:
      QL2.Term.new(type: :'DATUM', datum:
        QL2.Datum.new(type: :'R_STR', r_str: database)
      )
    )
  end
end
