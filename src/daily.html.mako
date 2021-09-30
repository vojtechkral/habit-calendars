<%
    import datetime
    from calendar import monthrange

    _ = month_name

    class Month:
        def __init__(self, num):
            self.name = month_name[num]
            self.days = monthrange(2000, num)[1] # Any leap year will do

    def gen_months():
        for m in range(1, 13):
            yield Month(m)

    months = gen_months()
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TODO:</title>
    <style type="text/css">
        @page {
            size: A4;
            margin: 5mm;
        }

        body {
            font-family: "Linux Libertine", serif;
            font-size: 8pt;
        }

        table {
            border-collapse: collapse;
            margin: .5em 0;
        }

        td {
            border: 1px solid black;
        }

        th.label {
            width: 35mm;
            text-align: left;
            font-size: 10pt;
        }

        td.tick {
            width: 1.25em;
            height: 1em;
        }
    </style>
</head>

<body>
% for month in months:
<table>
    <tr>
        <th class="label">${month.name}</th>
    % for day in range(1, month.days + 1):
        <th>${day}</th>
    % endfor
    </tr>

    % for i in range(0, 4):
        <tr>
            <td>&nbsp;</td>
        % for day in range(0, month.days):
             <td class="tick">&nbsp;</td>
        % endfor
        </tr>
    % endfor
</table>
% endfor

</body>
</html>
