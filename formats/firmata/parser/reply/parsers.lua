local signatures = request('!.formats.firmata.protocol.signatures')

local result =
  {
    [signatures.protocol_version] =
      {
        name = 'report_protocol_version',
        parser = request('report_protocol_version'),
      },
  }

local analog_report_parser =
  {
    name = 'analog_report',
    parser = request('analog_report'),
  }

for k, v in pairs(signatures.analog_report) do
  result[k] = analog_report_parser
end

local digital_report_parser =
  {
    name = 'digital_report',
    parser = request('digital_report'),
  }

for k, v in pairs(signatures.digital_report) do
  result[k] = digital_report_parser
end

return result
