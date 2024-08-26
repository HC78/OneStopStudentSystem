<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="OneStopStudentSystem.homepage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,300;1,400&display=swap" rel="stylesheet">
    <style>
        .designTitle {
            font-size: 50px;
            margin-top: -100px;
            margin-left: 50px;
            z-index: 1;
            position: relative;
        }

        h3 {
            color: #ffffff;
            font-size: 50px;
            position: absolute;
            transform: translate(-50%, -50%);
            border-style: solid;
            border-width: 2px;
            z-index: 1;
            width: 4700%;
        }

            h3:nth-child(1) {
                color: transparent;
                -webkit-text-stroke: 1.5px #ffffff;
            }

            h3:nth-child(2) {
                color: #ffffff;
                animation: animation 1s ease-in-out infinite;
            }

        @keyframes animation {
            0%, 100% {
                clip-path: polygon(0% 40%, 17% 44%, 34% 51%, 55% 56%, 71% 61%, 83% 55%, 100% 52%, 100% 100%, 0% 100%);
            }

            50% {
                clip-path: polygon(0% 50%, 13% 60%, 32% 66%, 50% 64%, 65% 50%, 82% 44%, 100% 43%, 100% 100%, 0% 100%);
            }
        }

        .section {
            min-height: 800px;
            margin-left: -1100px;
            margin-top: 100px;
            z-index: 1;
            position: relative;
        }

        .image {
            height: 1030px;
            position: fixed;
            width: 1030px;
            top: 10px;
            background-size: contain;
            background-repeat: no-repeat;
            mix-blend-mode: multiply;
            filter: blur(50px);
            opacity: 0;
            transition: filter 0.5s ease, opacity 3.5s ease, transform 3s ease;
            z-index: 1;
        }

        .section.active .image {
            opacity: 1;
            filter: blur(0);
            transform: translateX(0) translateY(0);
        }

        .slide-in-right {
            transform: translateX(100%);
        }

        .slide-in-left {
            transform: translateX(-100%);
        }

        .slide-in-top {
            transform: translateY(-100%);
        }

        .slide-in-bottom {
            transform: translateY(100%);
        }

        @keyframes move-twink-back {
            from {
                background-position: 0 0;
            }

            to {
                background-position: -10000px 5000px;
            }
        }

        @keyframes move-clouds-back {
            from {
                background-position: 0 0;
            }

            to {
                background-position: 10000px 0;
            }
        }

        .stars, .twinkling {
            position: absolute;
            top: 162px;
            left: 350px;
            right: 0;
            bottom: -10px;
            width: 1000px;
            height: 20%;
            box-shadow: 0 0 10px 5px #ffffff, 0 0 20px 10px #68565B, 0 0 30px 15px rgba(165, 42, 42, 0.6);
            border-radius: 100px;
        }

        .stars {
            background: #000 url('Image/stars.png') repeat top center;
        }

        .twinkling {
            background: transparent url('Image/twinkling.png') repeat top center;
            animation: move-twink-back 50s linear infinite;
        }

        * {
            box-sizing: border-box;
        }




        .mySlides {
            display: none;
        }

        img {
            vertical-align: middle;
        }

        /* Slideshow container */
        .slideshow-container {
            max-width: 1000px;
            position: relative;
            margin: auto;
        }

        /* Caption text */
        .text {
            color: chocolate;
            font-size: 30px;
            padding: 8px 12px;
            position: absolute;
            bottom: 8px;
            width: 100%;
            text-align: center;
              text-shadow: 0 0 10px yellow, 0 0 20px red, 0 0 30px blue;
               font-weight: bold;
        }

        /* Number text (1/3 etc) */
        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
        }

        /* The dots/bullets/indicators */
        .dot {
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
            transition: background-color 0.6s ease;
        }

        .active {
            background-color: #717171;
        }

        /* Fading animation */
        .fade {
            animation-name: fade;
            animation-duration: 1.5s;
        }

        @keyframes fade {
            from {
                opacity: .4
            }

            to {
                opacity: 1
            }
        }

        /* On smaller screens, decrease text size */
        @media only screen and (max-width: 300px) {
            .text {
                font-size: 11px large;
                color: brown
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="stars"></div>
    <div class="twinkling"></div>
    <div class="designTitle">
        &nbsp;
        <h3>Your Best One-Stop System</h3>
        <h3>Your Best One-Stop System</h3>
        <br />
        <br />
    </div>
    <br />
    <br />
    <br />
    <br />

    <div class="slideshow-container">

        <div class="mySlides fade">
            <div class="numbertext">1 / 3</div>
            <a href="BMI.aspx">
                <img src="/Image/heal.jpg" style="width: 1000px; height: 500px">
            </a>
            <div class="text">Stay healthy</div>
        </div>

        <div class="mySlides fade">
            <div class="numbertext">2 / 3</div>
            <a href="NoteTaking.aspx">
                <img src="/Image/nt.png" style="width: 1000px; height: 500px">
            </a>
            <div class="text">Keep going</div>
        </div>

        <div class="mySlides fade">
            <div class="numbertext">3 / 3</div>
            <a href="GPABeforeJuly.aspx">
                <img src="/Image/CGPA.jpg" style="width: 1000px; height: 500px">
            </a>
            <div class="text">Strive hard</div>
        </div>
    </div>
    <br>

    <div style="text-align: center">
        <span class="dot"></span>
        <span class="dot"></span>
        <span class="dot"></span>
    </div>
    <br>


    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <div class="section">
        <div class="image-container">
            <div class="image slide-in-right" style="background-image: url('Image/7.jpg')"></div>
        </div>
    </div>
    <div class="section">
        <div class="image-container">
            <div class="image slide-in-left" style="background-image: url('Image/2.jpg')"></div>
        </div>
    </div>
    <div class="section">
        <div class="image-container">
            <div class="image slide-in-right" style="background-image: url('Image/8.jpg')"></div>
        </div>
    </div>
    <div class="section">
        <div class="image-container">
            <div class="image slide-in-top" style="background-image: url('Image/3.jpg')"></div>
        </div>
    </div>
    <div class="section">
        <div class="image-container">
            <div class="image slide-in-left" style="background-image: url('Image/9.jpg')"></div>
        </div>
    </div>
    <div class="section">
        <div class="image-container">
            <div class="image slide-in-bottom" style="background-image: url('Image/4.jpg')"></div>
        </div>
    </div>

 <script>
     let scrollAmount = 0;
     const scrollStep = 2; // Scroll speed (2 pixels per step)
     const scrollInterval = 35; // Delay between each scroll step (in milliseconds)
     let scrollIntervalId;
     let lastScrollTop = 0; // Variable to keep track of the last scroll position
     let isScrollingDown = true; // Variable to determine scroll direction
     let autoScrollEnabled = true; // Flag to track if auto-scroll should be active

     function autoScroll() {
         function scrollDown() {
             // Scroll down by the scrollStep amount
             window.scrollBy(0, scrollStep);
             scrollAmount += scrollStep;

             // If we reach the bottom of the page, restart scrolling from the top
             if (scrollAmount >= document.body.scrollHeight - window.innerHeight) {
                 scrollAmount = 0;
                 window.scrollTo(0, 0);
             }
         }

         // Start scrolling by setting an interval
         scrollIntervalId = setInterval(scrollDown, scrollInterval);
     }

     // Function to stop auto-scrolling
     function stopAutoScroll() {
         clearInterval(scrollIntervalId); // Clear the scrolling interval
         autoScrollEnabled = false; // Disable auto-scroll when user interacts
     }

     function handleScroll() {
         const scrollTop = window.pageYOffset || document.documentElement.scrollTop;

         // Detect the scroll direction
         if (scrollTop > lastScrollTop) {
             isScrollingDown = true;
         } else {
             isScrollingDown = false;
         }

         lastScrollTop = scrollTop <= 0 ? 0 : scrollTop; // For Mobile or negative scrolling

         // If scrolling down and auto-scroll is not enabled, resume auto-scroll
         if (isScrollingDown && !autoScrollEnabled) {
             autoScrollEnabled = true; // Re-enable auto-scroll flag
             autoScroll(); // Start auto-scroll
         }

         // Stop auto-scroll when scrolling up
         if (!isScrollingDown && autoScrollEnabled) {
             stopAutoScroll();
         }
     }

     // Trigger the auto-scroll function when the page loads
     window.onload = autoScroll;

     // Stop auto-scrolling when the user clicks anywhere on the page
     document.addEventListener('click', stopAutoScroll);

     // Detect scroll events
     window.addEventListener('scroll', handleScroll);

     // Other existing functions (changeImage, showSlides, etc.) remain unchanged
     window.onscroll = function () { changeImage() };

     function changeImage() {
         var scroll = window.scrollY + (window.innerHeight / 2);

         [...document.getElementsByClassName('section')].forEach(el => {
             el.classList.remove('active');

             if (el.offsetTop <= scroll && el.offsetTop + el.offsetHeight > scroll) {
                 el.classList.add('active');
             }
         })
     }
     changeImage();

     let slideIndex = 0;
     showSlides();

     function showSlides() {
         let i;
         let slides = document.getElementsByClassName("mySlides");
         let dots = document.getElementsByClassName("dot");
         for (i = 0; i < slides.length; i++) {
             slides[i].style.display = "none";
         }
         slideIndex++;
         if (slideIndex > slides.length) { slideIndex = 1 }
         for (i = 0; i < dots.length; i++) {
             dots[i].className = dots[i].className.replace(" active", "");
         }
         slides[slideIndex - 1].style.display = "block";
         dots[slideIndex - 1].className += " active";
         setTimeout(showSlides, 4000);
     }

     function myFunction() {
         alert("This is the feedback from student who had use this system!");
     }
 </script>

</asp:Content>
