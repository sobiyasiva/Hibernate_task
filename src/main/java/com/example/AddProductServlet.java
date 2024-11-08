package com.example;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
@WebServlet("/addProductServlet")
public class AddProductServlet extends HttpServlet {
    private SessionFactory sessionFactory;
    @Override
    public void init() throws ServletException {
        // configure points to hibernate.Cfg.xml file and from that details it is building a sessionfactory 
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                Product newProduct = new Product(name, price);
            try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction(); 
            session.save(newProduct); 
            transaction.commit(); 

            }catch (Exception e) {
                System.out.println(e);
            }
            request.getSession().setAttribute("successMessage", "Product added successfully.");
            response.sendRedirect("product");
        }         
}
