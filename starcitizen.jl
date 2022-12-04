using DelimitedFiles
using CSV
using DataFrames, DataFramesMeta
using LightXML
using Dates

# cd("./remap/")
remap_loc = "./remap/js2_map.csv"
# map = CSV.read(map_loc, DataFrame)
remap_df = CSV.read(remap_loc, delim = ",", header = true, DataFrame)


function import_strings(input_loc)
  # import the input as a vector of strings
  open(input_loc) do f
      input = readlines(f)
  end
end

layout_loc = "./original_keybindings/layout_SUB_NXT_3-17_exported.xml"
keybinding = import_strings(layout_loc)

remap


for i in length(keybinding)
  for j in length(remap_df[!,1])
    if occursin(remap_df[j,1], keybinding[i])
      replace!(keybinding[i], remap_df[j,1] => remap_df[j,2])
    end
  end
end


t = now()
output_loc = "./output/layout_RCO_" * Dates.format(t, "yyyymmdd") * ".xml"


open(output_loc, "w") do io
  writedlm(io, keybinding)
end;



repla