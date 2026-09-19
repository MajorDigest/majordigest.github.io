<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/TR/REC-html40"
                xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>
<xsl:template match="/">
  <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
    <title>XML Sitemap</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="./favicon.ico" rel="shortcut icon" />
    <link href="./assets/styles.css" rel="stylesheet" />
    </head>
    <body class="sitemap">
    <a href="#main" class="skip-nav">Skip to Main Content</a>
    <header>
      <h1>
        <a href="/" aria-label="Major Digest Home"><img 
            src="/assets/logo.svg" alt="Major Digest Home"
            width="225" height="50" /></a>
        <span>Major Digest</span>
      </h1>
    </header>
    <nav>
      <a href="/us/" title="The Latest U.S. News From Most Reliable Sources">U.S.</a>
      <a href="/world/" title="Breaking News From Around the World">World</a>
      <a href="/tech/" title="The Latest Tech News and Headlines">Technology</a>
      <a href="/sports/" title="Stay Up to Date on Your Favorite Teams and Players">Sports</a>
      <a href="/politics/" title="The Latest Political News and Headlines">Politics</a>
    </nav>

    <main id="main" aria-label="Main content">
      <h2 style="margin:0 auto 0.5em;text-align:center">Major Digest XML Sitemap</h2>
      <table cellpadding="5" cellspacing="0" border="1">
        <tr>
          <th>URL</th>
          <th>Priority</th>
          <th>Change Frequency</th>
          <!--th>Last Modified</th-->
        </tr>
        <xsl:for-each select="sitemap:urlset/sitemap:url">
          <tr>
            <xsl:if test="position() mod 2 != 0">
              <xsl:attribute name="class">odd</xsl:attribute>
            </xsl:if>
            <td>
              <xsl:variable name="linkURL">
                <xsl:value-of select="sitemap:loc" />
              </xsl:variable>
              <a href="{$linkURL}"><xsl:value-of select="sitemap:loc" /></a>
            </td>
            <td align="right"><xsl:value-of select="sitemap:priority" /></td>
            <td><xsl:value-of select="sitemap:changefreq" /></td>
          </tr>
        </xsl:for-each>
        <tr>
          <td><a href="./sitemap.xml">https://majordigest.com/sitemap.xml</a></td>
          <td align="right">0.0</td><td>-</td>
        </tr>
      </table>
    </main>

    <footer>
      <div class="links">
        <a href="/terms/">Terms of Service</a> •
        <a href="/privacy/">Privacy Policy</a> •
        <a href="/disclaimer/">Disclaimer</a>
      </div>
      <div class="copy">
        <span class="icons">
          <a href="https://twitter.com/major_digest/" rel="external" target="_blank" title="Follow us on Twitter" aria-label="Follow us on Twitter"><svg role="img" aria-label="Twitter Logo" xmlns="http://www.w3.org/2000/svg" version="1.1" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 612 612"><path d="M612,116.258c-22.525,9.981-46.694,16.75-72.088,19.772c25.929-15.527,45.777-40.155,55.184-69.411 c-24.322,14.379-51.169,24.82-79.775,30.48c-22.907-24.437-55.49-39.658-91.63-39.658c-69.334,0-125.551,56.217-125.551,125.513 c0,9.828,1.109,19.427,3.251,28.606C197.065,206.32,104.556,156.337,42.641,80.386c-10.823,18.51-16.98,40.078-16.98,63.101 c0,43.559,22.181,81.993,55.835,104.479c-20.575-0.688-39.926-6.348-56.867-15.756v1.568c0,60.806,43.291,111.554,100.693,123.104 c-10.517,2.83-21.607,4.398-33.08,4.398c-8.107,0-15.947-0.803-23.634-2.333c15.985,49.907,62.336,86.199,117.253,87.194 c-42.947,33.654-97.099,53.655-155.916,53.655c-10.134,0-20.116-0.612-29.944-1.721c55.567,35.681,121.536,56.485,192.438,56.485 c230.948,0,357.188-191.291,357.188-357.188l-0.421-16.253C573.872,163.526,595.211,141.422,612,116.258z"></path></svg></a>
          <a href="https://www.facebook.com/majordigest" rel="external" target="_blank" title="Follow us on Facebook" aria-label="Follow us on Facebook"><svg role="img" aria-label="Facebook Logo" xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" x="0px" y="0px" viewBox="0 0 455.73 455.73"><path d="M0,0v455.73h242.704V279.691h-59.33v-71.864h59.33v-60.353c0-43.893,35.582-79.475,79.475-79.475h62.025v64.622h-44.382 c-13.947,0-25.254,11.307-25.254,25.254v49.953h68.521l-9.47,71.864h-59.051V455.73H455.73V0H0z"/></svg></a>
          <a href="https://www.instagram.com/majordigest" rel="external" target="_blank" title="Follow us on Instagram" aria-label="Follow us on Instagram"><svg role="img" aria-label="Instagram Logo" xmlns="http://www.w3.org/2000/svg" version="1.1" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 169.063 169.063"><path d="M122.406,0H46.654C20.929,0,0,20.93,0,46.655v75.752c0,25.726,20.929,46.655,46.654,46.655h75.752 c25.727,0,46.656-20.93,46.656-46.655V46.655C169.063,20.93,148.133,0,122.406,0z M154.063,122.407 c0,17.455-14.201,31.655-31.656,31.655H46.654C29.2,154.063,15,139.862,15,122.407V46.655C15,29.201,29.2,15,46.654,15h75.752 c17.455,0,31.656,14.201,31.656,31.655V122.407z"></path><path d="M84.531,40.97c-24.021,0-43.563,19.542-43.563,43.563c0,24.02,19.542,43.561,43.563,43.561s43.563-19.541,43.563-43.561 C128.094,60.512,108.552,40.97,84.531,40.97z M84.531,113.093c-15.749,0-28.563-12.812-28.563-28.561 c0-15.75,12.813-28.563,28.563-28.563s28.563,12.813,28.563,28.563C113.094,100.281,100.28,113.093,84.531,113.093z"></path><path d="M129.921,28.251c-2.89,0-5.729,1.17-7.77,3.22c-2.051,2.04-3.23,4.88-3.23,7.78c0,2.891,1.18,5.73,3.23,7.78 c2.04,2.04,4.88,3.22,7.77,3.22c2.9,0,5.73-1.18,7.78-3.22c2.05-2.05,3.22-4.89,3.22-7.78c0-2.9-1.17-5.74-3.22-7.78 C135.661,29.421,132.821,28.251,129.921,28.251z"></path></svg></a>
          <a href="https://play.google.com/store/apps/details?id=com.majordigest.android" rel="external" target="_blank" title="Download Android App" aria-label="Download Android App"><svg role="img" aria-label="Google Play Logo" xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" x="0px" y="0px" viewBox="0 0 32 32"><path d="M20.331 14.644l-13.794-13.831 17.55 10.075zM2.938 0c-0.813 0.425-1.356 1.2-1.356 2.206v27.581c0 1.006 0.544 1.781 1.356 2.206l16.038-16zM29.512 14.1l-3.681-2.131-4.106 4.031 4.106 4.031 3.756-2.131c1.125-0.893 1.125-2.906-0.075-3.8zM6.538 31.188l17.55-10.075-3.756-3.756z"/></svg></a>
        </span>
        ©
        <script>document.currentScript.outerHTML=new Date().getFullYear()</script>&#160;
        <a href="/about/" title="About Major Digest: A Journey from Idea to Publication">Major Digest</a>        
      </div>
    </footer>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>