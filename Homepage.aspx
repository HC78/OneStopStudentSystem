<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="OneStopStudentSystem.homepage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,300;1,400&display=swap" rel="stylesheet">
    <style>

        .designTitle { 
            font-size: 50px;
            margin-top: -100px;
            margin-left: 470px;
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
            width:4700%;
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
            margin-left: -350px;
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
            from {background-position: 0 0;}
            to {background-position: -10000px 5000px;}
        }

        @keyframes move-clouds-back {
            from {background-position: 0 0;}
            to {background-position: 10000px 0;}
        }

        .stars, .twinkling {
            position:absolute;
            top: 162px;
            left: 350px;
            right: 0;
            bottom: -10px;
            width: 1000px;
            height: 20%;
            box-shadow: 
            0 0 10px 5px #ffffff, 
            0 0 20px 10px #68565B, 
            0 0 30px 15px rgba(165, 42, 42, 0.6) ; 
            border-radius:100px;
        }

        .stars {
            background: #000 url('Image/stars.png') repeat top center;
        }

        .twinkling {
            background: transparent url('Image/twinkling.png') repeat top center;
            animation: move-twink-back 50s linear infinite;
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
    <br /><br /><br /><br /><br /><br /><br />
    <br /><br />
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
        window.onscroll = function () { changeImage() }

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
    </script>
</asp:Content>
