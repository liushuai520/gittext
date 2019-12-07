package com.zking.shiro01;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;

/**
 * @company Admin
 * @create 2019-11-27 19:03
 */
public class ShiroDemo {

    public static void main(String[] args) {
        //1.读取加载shiro.ini配置文件
        IniSecurityManagerFactory iniSecurityManagerFactory=new
                IniSecurityManagerFactory("classpath:shiro-permission.ini");
        //2.创建SecurityManager安全管理器
        SecurityManager securityManager = iniSecurityManagerFactory.getInstance();
        //3.将SecurityManager委托给SecurityUtils管理
        SecurityUtils.setSecurityManager(securityManager);
        //4.获取Subject主体
        Subject subject = SecurityUtils.getSubject();
        //5.创建Token,进行账号密码管理
        UsernamePasswordToken token=new UsernamePasswordToken(
                  "admin",
                  "123"
        );
        //6.身份验证
        try {
            subject.login(token);
            System.out.println("身份验证成功");
        } catch (AuthenticationException e) {
            e.printStackTrace();
        }
        //8.验证角色
        try {
            if (subject.hasRole("role1")) {
                System.out.println("角色验证成功");
            } else {
                System.out.println("角色验证失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //9.权限验证
        try {
            if (subject.isPermitted("user:create")) {
                System.out.println("权限验证成功");
            } else {
                System.out.println("权限验证失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //7.安全退出
        subject.logout();
    }
}
