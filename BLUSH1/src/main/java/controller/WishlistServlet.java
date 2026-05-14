package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/help")
public class HelpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String msg = request.getParameter("message");

        if (msg == null || msg.trim().isEmpty()) {

            response.setContentType("text/plain");
            response.getWriter().write(
                "😊 Please enter your question."
            );
            return;
        }

        // Original Message
        String originalMsg = msg.trim();

        // Lowercase for matching
        msg = originalMsg.toLowerCase();

        String reply = "";

        // =========================
        // GREETING
        // =========================
        if (msg.contains("hello")
                || msg.contains("hi")
                || msg.contains("hey")) {

            reply =
                "👋 Hello! Welcome to BLUSHBERRY Beauty Assistant 💖\n"
              + "How may I help you today?\n\n"
              + "You can ask about:\n"
              + "• Orders\n"
              + "• Delivery\n"
              + "• Cancel / Return / Exchange\n"
              + "• Makeup Products\n"
              + "• Skincare\n"
              + "• Haircare\n"
              + "• Perfumes\n"
              + "• Customer Support";
        }
        //forget password
        else if (msg.contains("forgot password")
                || msg.contains("forget password")
                || msg.contains("reset password")
                || msg.contains("password")) {

            reply =
                "🔐 Don't worry! If you forgot your password, please contact our helpline:\n\n"
              + "+91 9123040662\n"
              + "+91 8100246464\n\n"
              + "Our team will guide you through the further steps to reset your password.";
        }

        // =========================
        // LOGIN
        // =========================
        else if (msg.contains("login")
                || msg.contains("log in")
                || msg.contains("sign in")) {

            reply =
                "🔐 Login Process:\n\n"
              + "1. Open the Login page.\n"
              + "2. Enter your email and password.\n"
              + "3. Click on Login button.\n"
              + "4. You will be redirected to your account.";
        }

        // =========================
        // SIGNUP
        // =========================
        else if (msg.contains("signup")
                || msg.contains("sign up")
                || msg.contains("register")
                || msg.contains("create account")) {

            reply =
                "📝 Signup Process:\n\n"
              + "1. Open the Signup page.\n"
              + "2. Enter your name, email and password.\n"
              + "3. Click on Signup button.\n"
              + "4. Your account will be created successfully.";
        }

        // =========================
        // CUSTOMER SUPPORT
        // =========================
        else if (msg.contains("help")
                || msg.contains("support")
                || msg.contains("customer care")) {

            reply =
                "📞 BLUSHBERRY Customer Support:\n\n"
              + "☎️ +91 9123040662\n"
              + "☎️ +91 8100246464\n\n"
              + "🕒 Support Available: 10 AM - 8 PM";
        }

        // =========================
        // URGENT CALL
        // =========================
        else if (msg.contains("call")
                || msg.contains("urgent")) {

            reply =
                "☎️ For urgent help please contact immediately:\n\n"
              + "+91 9123040662\n"
              + "+91 8100246464";
        }

        // =========================
        // ORDER STATUS
        // =========================
        else if (msg.contains("where is my order")
                || msg.contains("track order")
                || msg.contains("order status")) {

            reply =
                "📦 Please provide your Order ID to check your order status.";
        }

        // =========================
        // CANCEL ORDER
        // =========================
        else if (msg.contains("cancel order")
                || msg.contains("cancel my order")
                || msg.contains("order cancel")) {

            reply =
                "❌ Please provide your Order ID to proceed with cancellation.";
        }

        // =========================
        // RETURN ORDER
        // =========================
        else if (msg.contains("return")
                || msg.contains("return order")
                || msg.contains("refund")
                || msg.contains("return product")) {

            reply =
                "↩️ Please provide your Order ID to start your return/refund request.";
        }

        // =========================
        // EXCHANGE ORDER
        // =========================
        else if (msg.contains("exchange")
                || msg.contains("replace")
                || msg.contains("wrong product")) {

            reply =
                "🔄 Please provide your Order ID to process your exchange request.";
        }

        // =========================
        // ORDER ID DETECTION
        // Example:
        // ORD12345
        // BB1001
        // 12345
        // =========================
        else if (originalMsg.matches("(?i)[A-Z]{0,5}\\d{4,}")) {

            reply =
                "📦 Order ID: " + originalMsg.toUpperCase() + "\n\n"
              + "✅ Your request has been received  successfully.\n"
              + "Our BLUSHBERRY support team will contact you shortly regarding your order update.";
        }

        // =========================
        // DELIVERY
        // =========================
        else if (msg.contains("delivery")
                || msg.contains("date")
                || msg.contains("shipping")) {

            reply =
                "🚚 Your order delivery date is shown in the Orders section of your account.";
        }

        // =========================
        // OILY SKIN
        // =========================
        else if (msg.contains("oily skin")) {

            reply =
                "✨ Recommended for oily skin:\n\n"
              + "• Oil-free face wash\n"
              + "• Matte sunscreen\n"
              + "• Compact powder\n"
              + "• Face serum";
        }

        // =========================
        // DRY SKIN
        // =========================
        else if (msg.contains("dry skin")) {

            reply =
                "💧 Recommended for dry skin:\n\n"
              + "• Hydrating cleanser\n"
              + "• Moisturizer\n"
              + "• Face serum\n"
              + "• Face mask";
        }

        // =========================
        // BLUSH
        // =========================
        else if (msg.contains("blush")) {

            reply =
                "🌸 BLUSHBERRY Blush Collection:\n\n"
              + "• Peach Blush\n"
              + "• Pink Blush\n"
              + "• Nude Blush\n"
              + "• Long-lasting Matte Blush";
        }

        // =========================
        // SHAMPOO
        // =========================
        else if (msg.contains("shampoo")) {

            reply =
                "🧴 Recommended BLUSHBERRY Shampoos:\n\n"
              + "• Onion Shampoo\n"
              + "• Keratin Shampoo\n"
              + "• Anti-Dandruff Shampoo\n"
              + "• Smooth & Shine Shampoo";
        }

        // =========================
        // SERUM
        // =========================
        else if (msg.contains("serum")
                || msg.contains("face serum")) {

            reply =
                "✨ Recommended Face Serums:\n\n"
              + "• Vitamin C Serum\n"
              + "• Hyaluronic Acid Serum\n"
              + "• Glow Serum\n"
              + "• Acne Control Serum";
        }

        // =========================
        // FACE MASK
        // =========================
        else if (msg.contains("face mask")
                || msg.contains("mask")) {

            reply =
                "🩷 Recommended Face Masks:\n\n"
              + "• Charcoal Face Mask\n"
              + "• Hydrating Sheet Mask\n"
              + "• Glow Face Mask\n"
              + "• Aloe Vera Face Mask";
        }

        // =========================
        // MAKEUP BRUSH
        // =========================
        else if (msg.contains("brush")
                || msg.contains("makeup brush")) {

            reply =
                "💄 Makeup Brush Collection:\n\n"
              + "• Foundation Brush\n"
              + "• Blush Brush\n"
              + "• Eyeshadow Brush\n"
              + "• Full Makeup Brush Set";
        }

        // =========================
        // COMPACT
        // =========================
        else if (msg.contains("compact")) {

            reply =
                "✨ BLUSHBERRY Compact Powder:\n\n"
              + "• Matte Finish Compact\n"
              + "• Waterproof Compact\n"
              + "• Long-lasting Compact Powder";
        }

        // =========================
        // EYELINER
        // =========================
        else if (msg.contains("eyeliner")) {

            reply =
                "👁️ BLUSHBERRY Eyeliners:\n\n"
              + "• Waterproof Eyeliner\n"
              + "• Matte Black Eyeliner\n"
              + "• Long-lasting Liquid Eyeliner";
        }

        // =========================
        // LIPSTICK
        // =========================
        else if (msg.contains("lipstick")) {

            reply =
                "💄 BLUSHBERRY Lipsticks:\n\n"
              + "• Matte Lipstick\n"
              + "• Waterproof Lipstick\n"
              + "• Nude Shades\n"
              + "• Long-lasting Lip Colors";
        }

        // =========================
        // SUNSCREEN
        // =========================
        else if (msg.contains("sunscreen")
                || msg.contains("spf")) {

            reply =
                "🌞 Recommended Sunscreen:\n\n"
              + "• SPF 50 Sunscreen\n"
              + "• Matte Sunscreen\n"
              + "• Waterproof Sunscreen";
        }

        // =========================
        // PERFUME
        // =========================
        else if (msg.contains("perfume")) {

            reply =
                "🌸 BLUSHBERRY Perfume Collection:\n\n"
              + "• Floral Perfume\n"
              + "• Vanilla Perfume\n"
              + "• Aqua Fragrance\n"
              + "• Woody Perfume";
        }

        // =========================
        // SOAP
        // =========================
        else if (msg.contains("soap")) {

            reply =
                "🧼 Recommended Soaps:\n\n"
              + "• Aloe Vera Soap\n"
              + "• Charcoal Soap\n"
              + "• Moisturizing Soap";
        }

        // =========================
        // SHAVING
        // =========================
        else if (msg.contains("shaving")
                || msg.contains("beard")) {

            reply =
                "🪒 Recommended Men's Grooming Products:\n\n"
              + "• Shaving Foam\n"
              + "• Beard Oil\n"
              + "• Beard Wash\n"
              + "• Aloe Vera Shaving Cream";
        }

        // =========================
        // SANITARY PADS
        // =========================
        else if (msg.contains("pad")
                || msg.contains("period")) {

            reply =
                "🩷 Recommended Sanitary Pads:\n\n"
              + "• Cotton Soft Pads\n"
              + "• Overnight XL Pads\n"
              + "• Ultra Thin Pads";
        }

        // =========================
        // THANK YOU
        // =========================
        else if (msg.contains("thank you")
                || msg.contains("thanks")) {

            reply =
                "😊 You're welcome ❤️\n"
              + "Thank you for choosing BLUSHBERRY 💖";
        }

        // =========================
        // PRODUCT SUGGESTION
        // =========================
        else if (msg.contains("suggestion")
                || msg.contains("what can i order")
                || msg.contains("what can i buy")) {

            reply =
                "🛍️ You can shop from BLUSHBERRY:\n\n"
              + "• Makeup Products\n"
              + "• Skincare\n"
              + "• Face Serum\n"
              + "• Face Masks\n"
              + "• Blush & Compact\n"
              + "• Eyeliner & Lipsticks\n"
              + "• Shampoo & Haircare\n"
              + "• Perfumes\n"
              + "• Men's Grooming\n"
              + "• Sanitary Pads\n"
              + "• Daily Personal Care Products 💖";
        }

        // =========================
        // DEFAULT
        // =========================
        else {

            reply =
                "❓ Sorry, I could not understand your message.\n\n"
              + "📞 Please contact BLUSHBERRY Customer Support:\n"
              + "+91 9123040662\n"
              + "+91 8100246464";
        }

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(reply);
    }
}
