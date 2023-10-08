package org.vedzevgn.web.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.LinkedList;
import java.util.Map;
import java.util.Objects;

@WebServlet(name = "controllerServlet", value = "/controller")
public class ControllerServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String forwardPath = getServletContext().getContextPath();

        if (Objects.equals(request.getParameter("clear"), "true")) {
            LinkedList<Map<String, Object>> list = new LinkedList<Map<String, Object>>();
            getServletContext().setAttribute("pointsList", list);
        }

        if (request.getParameter("x") != null
            && request.getParameter("y") != null
            && request.getParameter("r") != null)
        {
            forwardPath = this.getServletContext().getContextPath() + "/area-check?x=" + request.getParameter("x") + "&y=" + request.getParameter("y") + "&r=" + request.getParameter("r");
        }

        response.sendRedirect(forwardPath);
    }
}
