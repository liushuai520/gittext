package com.zking.shiro01.servlet;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @company Admin
 * @create 2019-11-27 22:26
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //获取登录账号密码
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        //创建账号密码登录
        UsernamePasswordToken token = new UsernamePasswordToken(
                username,
                password
        );
        //获取主体Subjiect
        Subject subject = SecurityUtils.getSubject();

        try {
            //身份验证
            subject.login(token);
            req.getRequestDispatcher("/main.jsp").forward(req,resp);
            req.getSession().setAttribute("username",username);
        } catch (AuthenticationException e) {
            req.getRequestDispatcher("/main.jsp").forward(req,resp);
            req.getSession().setAttribute("message","账号或者密码错误");
            e.printStackTrace();
        }


    }
}
