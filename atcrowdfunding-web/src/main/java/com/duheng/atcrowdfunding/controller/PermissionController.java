package com.duheng.atcrowdfunding.controller;

import com.duheng.atcrowdfunding.bean.TPermission;
import com.duheng.atcrowdfunding.service.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/*************************
 Author: 杜衡
 Date: 2020/2/26
 Describe:
 *************************/
@Controller
@RequestMapping("/jurisdiction")
public class PermissionController {
    @Autowired
    private IPermissionService permissionService;

    @RequestMapping("/search")
    @ResponseBody
    public List<TPermission> search(){
        return permissionService.getPermissions();
    }

    @RequestMapping("/save")
    @ResponseBody
    public String save(TPermission permission){
       int num = permissionService.savePermission(permission);
       if(num > 0){
           return "success";
       }
        return "fail";
    }
    @RequestMapping("/get")
    @ResponseBody
    public TPermission get(Integer id){
        return permissionService.get(id);
    }
    @RequestMapping("/remove")
    @ResponseBody
    public String remove(Integer id){
        int num = permissionService.removePermission(id);
        if (num > 0) {
            return "success";
        }
        return "fail";
    }
    @RequestMapping("/modify")
    @ResponseBody
    public String modify(TPermission per){
        int num = permissionService.updatePermission(per);
        if (num > 0) {
            return "success";
        }
        return "fail";
    }
}
