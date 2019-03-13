#!/usr/bin/env python
# -*- coding: utf-8 -*-

#script for ssh_keys_audit_report.xlsx file creation from summary_ssh_keys_info.csv

import pandas as pd

filepath_in="summary_ssh_keys_info.csv"
df = pd.read_csv(filepath_in)


writer = pd.ExcelWriter('ssh_keys_audit_report.xlsx', engine='xlsxwriter')
df.to_excel(writer, index=False, sheet_name='ssh keys audit report')
workbook = writer.book
worksheet = writer.sheets['ssh keys audit report']


# Set up some formatting and text to highlight the panes.
header_format = workbook.add_format({'bold': True,
                                     'align': 'center',
                                     'valign': 'vcenter',
                                     'bg_color': '#D7E4BC',
                                     'border': 1})

# Set up default formatting
default_format = workbook.add_format({'align': 'left',
                                      'valign': 'vcenter',
                                      'border': 1})

# Set up center horisontal alignment formatting
center_format = workbook.add_format({'align': 'center',
                                     'valign': 'vcenter',
                                     'border': 1})

#freeze first row
worksheet.freeze_panes(1, 0)
#set autofilter
worksheet.autofilter('A1:K1000000')

#set default format on all columns
worksheet.set_column('A:K', None, default_format)


#set header format on first row
worksheet.conditional_format('A1:K1', {'type':   'no_errors',
                                       'format': header_format})

#set specific columns width and format
worksheet.set_column('A:A', 16)
worksheet.set_column('B:B', 20)
worksheet.set_column('C:C', 13)
worksheet.set_column('D:D', 15, center_format)
worksheet.set_column('E:E', 22, center_format)
worksheet.set_column('F:F', 24, center_format)
worksheet.set_column('G:G', 19, center_format)
worksheet.set_column('H:H', 13, center_format)
worksheet.set_column('I:I', 27)
worksheet.set_column('J:J', 29)
worksheet.set_column('K:K', 25)

writer.save()