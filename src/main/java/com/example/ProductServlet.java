package com.example;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
// import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
// import org.hibernate.query.Query;

public class ProductServlet extends HttpServlet {
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
            sessionFactory = new Configuration().configure().buildSessionFactory();  
    }
            @Override
            protected void doGet(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {
                List<Product> productList = fetchAllProducts();
                request.setAttribute("productList", productList);
                request.getRequestDispatcher("products.jsp").forward(request, response);
            }     
    
    public List<Product> fetchAllProducts() {
        List<Product> productList = null;
        try (Session session = sessionFactory.openSession()) {
            productList = session.createQuery("FROM Product", Product.class).list();
        } catch (Exception e) {
           System.out.println(e);
        }
        return productList;
    }

  
}

    