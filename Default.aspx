<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--<div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Getting started</h2>
            <p>
                ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
            A design surface and hundreds of controls and components let you rapidly build sophisticated, powerful UI-driven sites with data access.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301948">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Get more libraries</h2>
            <p>
                NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Web Hosting</h2>
            <p>
                You can easily find a web hosting company that offers the right mix of features and price for your applications.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
            </p>
        </div>
    </div>--%>

    <div class="section-container" style="background-image:url(Content/images/gujaratmap.jpg);background-repeat:no-repeat;background-size:cover">
        <div>
             <div class="inner-div marquee-outer" style="margin:5px;border:1px solid #AE0C5E;">
                <div style="text-align:center;width:100%"><b style="text-decoration:underline;text-align:center">Updates</b></div>
                <div class="marquee-inner">
                    <p>Prime minister to launch Swacch Bharat Abhiyan in Ahmedabad</p>
                    <p>Two more talukas to be covered by AMC</p>
                    <p>Amreli to get fresh water supply from Sardar Sarovar dam soon</p>
                </div>
            </div>
             <div class="inner-div marquee-outer" style="margin:5px;border:1px solid #AE0C5E;color:blue">
                <div style="text-align:center;width:100%"><b style="text-decoration:underline;text-align:center">Our Activities at a glance</b></div>
                <div>
                    <div id="slideshow">
                    <div><img src="<%:System.Web.VirtualPathUtility.ToAbsolute("/Content/images/Glance1.jpg") %>" alt=""></div>
                    <div><img src="<%:System.Web.VirtualPathUtility.ToAbsolute("/Content/images/Glance2.jpg") %>" alt=""></div>
                    <div><img src="<%:System.Web.VirtualPathUtility.ToAbsolute("/Content/images/Glance3.jpg") %>" alt=""></div>
                    <div><img src="<%:System.Web.VirtualPathUtility.ToAbsolute("/Content/images/Glance4.jpg") %>" alt=""></div>
                    </div>
                </div>
            </div>
        </div>
        <div>
        <div class="inner-div">
            <span></span>
        </div>
        </div>
         <div >
             <div class="inner-div marquee-outer" style="margin:5px;border:1px solid #AE0C5E;color:green">
                <div style="text-align:center;width:100%"><b style="text-decoration:underline;text-align:center;">Notifications</b></div>
                <div class="marquee-inner">
                    <p>Recruitment notice for Group-B and D posts in various departments</p>
                    <p>Tenders invited for construction of Barrages at Nal Sarovar, Mehsana</p>
                    <p>Tenders invited for construction of Flyover at Vadaj, Ahmedabad</p>
                </div>
            </div>
               <div class="inner-div marquee-outer" style="margin:5px;border:1px solid #AE0C5E;color:brown">
                <div style="text-align:center;width:100%"><b style="text-decoration:underline;text-align:center;">Contact Us</b></div>
                <div class="marquee-inner">
                    <div>G-52, GIDC Block,
                            Nariman House
                            Sarkhej Gandhinagar Highway,
                            Ahmedabad - 380089
                       </div>
                    <p>Phone no.-079-986574123</p>
                    
                </div>
            </div>
        </div>
  </div>
    <script type="text/javascript">
        $("#slideshow > div:gt(0)").hide();

        setInterval(function () {
            $('#slideshow > div:first')
              .fadeOut(1000)
              .next()
              .fadeIn(1000)
              .end()
              .appendTo('#slideshow');
        }, 3000);
    </script>

</asp:Content>
