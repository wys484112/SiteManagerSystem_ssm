package com.sojson.viewresolver;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.sojson.common.model.UPermission;

public class ViewExcel extends AbstractExcelView {

    @SuppressWarnings("unchecked")
    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        
        String fileName = "权限列表excel.xls";  
        response.setCharacterEncoding("UTF-8");  
        response.setContentType("application/ms-excel");  
        response.setHeader("Content-Disposition", "inline; filename="+new String(fileName.getBytes(),"iso8859-1"));  
        OutputStream outputStream = response.getOutputStream();
        
        List<UPermission> userList = (List<UPermission>) model.get("userList");
        // 产生Excel表头
        HSSFSheet sheet = workbook.createSheet("基本信息");
        HSSFRow header = sheet.createRow(0);
        // 产生标题列
        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("名字");
        header.createCell(2).setCellValue("url");
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("mm/dd/yyyy"));
        int rowNumber = 1;
        for (UPermission user : userList) {
            HSSFRow row = sheet.createRow(rowNumber++);
            // 产生标题列
            row.createCell(0).setCellValue(user.getId());
            row.createCell(1).setCellValue(user.getName());
            row.createCell(2).setCellValue(user.getUrl());
        }
        workbook.write(outputStream);
        outputStream.flush();
        outputStream.close();
    }
}