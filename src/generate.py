#!/usr/bin/env python3

import locale
import calendar
from datetime import date
from mako.template import Template

LOCALE_MONTHS = {
    'cs_CZ': [ '', 'Leden', 'Únor', 'Březen', 'Duben', 'Květen',
        'Červen', 'Červenec', 'Srpen', 'Září', 'Říjen', 'Listopad', 'Prosinec' ],
}

def month_name(locale):
    return LOCALE_MONTHS.get(locale, calendar.month_name)

def render(template, target, lang, year=date.today().year, per_week=1):
    locale.setlocale(locale.LC_ALL, '%s.UTF-8' % lang)

    template = Template(filename='src/%s' % template)
    context = {
        'month_name': month_name(lang),
        'year': int(year),
        'per_week': int(per_week),
    }

    with open('html/%s' % target, "w") as file:
        file.write(template.render(**context))

def main():
    render('daily.html.mako', 'en-daily.html', 'en_US')
    render('daily.html.mako', 'cz-denni.html', 'cs_CZ')
    for year in range(2021, 2023):
        for per_week in range(1, 6):
            render('weekly.html.mako', 'cz-tydenni-%s-%s.html' % (year, per_week), 'cs_CZ', year, per_week)
            render('weekly.html.mako', 'en-weekly-%s-%s.html' % (year, per_week), 'cs_CZ', year, per_week)

if __name__ == '__main__':
    main()
