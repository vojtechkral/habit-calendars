<%
    import datetime
    ## from calendar import monthrange

    _ = month_name

    def first_week_monday(year):
        # 1.1. might still be in the old year,
        # iterate until we find the first week
        for d in range(1, 7):
            date = datetime.date(year, 1, d)
            if date.isocalendar().week == 1:
                # First week found, scroll back to monday
                # (which might be in the old year)
                return date - datetime.timedelta(days=date.weekday())

        raise NotImplementedError("Unreachable")

    class Week:
        def __init__(self, date):
            self.num = date.isocalendar().week
            self.start = date
            self.end = date + datetime.timedelta(days=6)
            ## self.name = month_name[num]
            ## self.days = monthrange(2000, num)[1] # Any leap year will do

    def gen_weeks(year):
        date = first_week_monday(year)
        while date.year <= year:
            yield Week(date)
            date += datetime.timedelta(days=7)

    class Month:
        def __init__(self, first_week):
            self.month = first_week.end.month
            self.name = month_name[self.month]
            self.weeks = [first_week]

    def gen_months(year):
        weeks = gen_weeks(year)
        first_week = next(weeks)
        month = Month(first_week)
        for w in weeks:
            if w.start.month > month.month:
                yield month
                month = Month(w)
            else:
                month.weeks.append(w)

        yield month

    months = gen_months(year)
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

            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 2em 2em;
        }

        table {
            border-collapse: collapse;
        }

        td {
            border: 1px solid black;
        }

        th.label {
            width: 25mm;
            text-align: left;
            font-size: 10pt;
        }

        th.week {
            border: 1px solid black;
            min-width: ${max(per_week, 3)}em;
        }

        .week-range {
            font-weight: normal;
            font-size: 6pt;
            padding: 0 1mm;
        }

        td.tick {
            height: 1em;
        }
    </style>
</head>

<body>
% for month in months:
    <table>
        <tr>
            <th class="label">${month.name}</th>
        % for week in month.weeks:
            <th colspan="${per_week}" class="week">
                ${week.num}
                <div class="week-range">${week.start.day}.~${week.end.day}.</th>
            </th>
        % endfor
        </tr>

        % for i in range(0, 5):
            <tr>
                <td>&nbsp;</td>
            % for week in month.weeks:
                % for i in range(0, per_week):
                    <td class="tick">&nbsp;</td>
                % endfor
            % endfor
            </tr>
        % endfor
    </table>
% endfor
</body>
</html>
