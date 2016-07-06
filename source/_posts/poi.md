---
title: poi
date: 2016-01-15 10:52:51
tags: [poi]
---
设置背景色
HSSFWorkbook wb = new HSSFWorkbook();
HSSFCellStyle style = wb.createCellStyle();
style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
style.setFillForegroundColor(HSSFColor.WHITE.index);
cell.setCellStyle(style);  //cell 是 HSSFCell 对象
