package com.duheng.atcrowdfunding.controller;

import com.duheng.atcrowdfunding.bean.TAdmin;
import com.duheng.atcrowdfunding.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/*************************
 Author: 杜衡
 Date: 2020/2/23
 Describe:
 *************************/
@RestController
public class AdminController {

    @Autowired
    protected IAdminService iAdminService;

    @GetMapping("/admin/gets")
    public List<TAdmin> gets(){
        return iAdminService.queryAdmins();
    }
}
