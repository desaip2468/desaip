require 'csv'
require 'set'
require 'colorize'

src_filename = 'output15.csv'
dst_filename = 'ppdb_data_selected.csv'

total_count = `cat #{src_filename} | wc -l`.chomp

panel_ids_set = Set.new

puts "Gathering panel_id sets from #{src_filename}"
i = 0
total_count = `cat #{src_filename} | wc -l`.chomp

CSV.foreach(src_filename, headers: true) do |row|
  i += 1
  print "\r#{i}/#{total_count}"
  panel_ids_set << row['panel_id']
end

save_headers = %w[
  Y0001
  Y0002
  Y0003
  Y0004
  Y0005
  Y0006
  Y0007
  Y0008
  Y0009
  Y0010
  F0001
  F0002
  F0003
  F0004
  F0005
  F0006
  F0007
  F0008
  F0009
  F0010
  F0011
  F0012
  F0013
  F0014
  F0015
  F0016
  F0017
  F0018
  F0019
  F0020
  F0021
  F0022
  F0023
  F0024
  F0025
  F0026
  F0027
  F0028
  F0029
  F0030
  F0031
  F0032
  F0033
  F0034
  F0035
  F0036
  F0037
  F0038
  F0039
  F0040
  F0041
  F0042
  F0043
  F0044
  F0045
  F0046
  F0047
  F0048
  F0049
  F0050
  F0051
  F0052
  F0053
  F0054
  F0055
  F0056
  F0057
  G0001
  G0002
  G0003
  G0004
  G0005
  G0006
  G0007
  G0008
  G0009
  G0010
  G0011
  G0012
  G0013
  G0014
  G0015
  G0016
  G0017
  G0018
  G0019
  G0020
  G0021
  G0022
  G0023
  G0024
  G0025
  G0026
  G0027
  H0001
  H0002
  H0003
  H0004
  H0005
  H0006
  H0007
  H0008
  H0009
  H0010
  H0011
  H0012
  H0013
  H0014
  H0015
  H0016
  H0017
  H0018
  H0019
  H0020
  H0021
  H0022
  I0001
  I0002
  I0003
  I0004
  I0005
  I0006
  I0007
  I0008
  I0009
  I0010
  I0011
  I0012
  I0013
  I0014
  I0015
  I0016
  I0017
  I0018
  I0019
  I0020
  I0021
  I0022
  I0023
  I0024
  I0025
  I0026
  I0027
  I0028
  I0029
  I0030
  I0031
  I0032
  I0033
  I0034
  I0035
  I0036
  I0037
  I0038
  I0039
  I0040
  I0041
  I0042
  I0043
  I0044
  I0045
  I0046
  I0047
  I0048
  I0049
  I0050
  I0051
  I0052
  I0053
  I0054
  I0055
  I0056
  I0057
  I0058
  I0059
  I0060
  I0061
  I0062
  I0063
  I0064
  I0065
  I0066
  I0067
  I0068
  I0069
  I0070
  I0071
  I0072
  I0073
  I0074
  I0075
  I0076
  I0077
  I0078
  I0079
  I0080
  I0081
  I0082
  I0083
  I0084
  I0085
  I0086
  I0087
  I0088
  I0089
  I0090
  I0091
  I0092
  J0001
  J0002
  J0003
  J0004
  J0005
  J0006
  J0007
  J0008
  J0009
  J0010
  J0011
  J0012
  J0013
  J0014
  J0015
  J0016
  J0017
  J0018
  J0019
  J0020
  J0021
  J0022
  J0023
  J0024
  J0025
  J0026
  J0027
  J0028
  J0029
  J0030
  J0031
  J0032
  J0033
  J0034
  J0078
  J0079
  J0080
  J0081
  J0082
  J0083
  J0084
  J0085
  K0001
  K0002
  K0003
  K0004
  K0005
  K0006
  K0007
  K0008
  K0009
  K0010
  K0011
  K0012
  K0013
  K0014
  K0015
  K0016
  K0017
  K0018
  K0019
  K0020
  K0021
  K0022
  K0023
  K0024
  K0025
  K0026
  K0027
  K0028
  K0029
  K0030
  K0031
  K0032
  K0033
  K0034
  K0035
  K0036
  K0037
  K0038
  K0039
  K0040
  K0041
  K0042
  K0043
  K0044
  K0045
  K0046
  K0047
  K0048
  K0049
  K0050
  K0051
  K0052
  K0053
  K0054
  K0055
  K0056
  K0057
  K0058
  K0059
  K0060
  K0061
  K0062
  K0063
  K0064
  K0065
  K0066
  L0001
  L0002
  L0003
  L0004
  L0005
  L0006
  L0007
  L0008
  L0010
  L0011
  L0012
  L0013
  L0014
  L0015
  L0016
  L0017
  L0019
  L0020
  L0021
  L0022
  L0023
  L0024
  L0025
  L0026
  L0027
  L0028
  L0029
  L0030
  L0031
  M0001
  M0002
  M0003
  M0004
  M0005
  M0006
  M0007
  M0008
  M0009
  M0010
  M0011
  M0012
  M0013
  M0014
  M0015
  M0016
  M0017
  M0018
  M0019
  M0020
  M0021
  M0022
  M0023
  M0024
  M0025
  M0026
  M0027
]

puts "Analyzing #{dst_filename} ..."
dst_hash = {}

i = 0
total_count = `cat #{dst_filename} | wc -l`.chomp
CSV.foreach(dst_filename, headers: true) do |row|
  panel_id = row['id']
  i += 1
  print "\r#{i}/#{total_count}"
  if panel_ids_set.include? panel_id
    dst_hash[panel_id] = save_headers.map {|header| row[header]}
  end
end

puts "Generating output ..."
i = 0
total_count = `cat #{src_filename} | wc -l`.chomp
output = CSV.generate do |csv|
  CSV.foreach(src_filename, headers: true) do |row|
    csv << row.headers + save_headers if i == 0
    i += 1
    print "\r#{i}/#{total_count}"
    panel_id = row['panel_id']

    key = dst_hash[panel_id] || save_headers.map {'NULL'}
    csv << row.to_a.map(&:last) + key
  end
end

File.write('output16.csv', output)
