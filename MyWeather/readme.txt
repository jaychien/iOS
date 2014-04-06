更新日期和歷史修改
====================
2014/04/06: 第一版的天氣預報：台灣


資料來源
====================
http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-001.xml

三十六小時天氣預報



<head>
    <product>
        <title>三十六小時天氣預報</title>
        <version>2.0</version>
    </product>
    <issue-time>2014-04-06T17:00:00+08:00</issue-time>
    <updated>2014-04-06T17:00:00+08:00</updated>
</head>

<data category="forecasts">
    <location type="region">
        <name>臺北市</name>
        <weather-elements>
        <Wx>
            <time start="2014-04-06T18:00:00+08:00" end="2014-04-07T06:00:00+08:00">
                <text>多雲時陰短暫陣雨</text>
                <value>12</value>
            </time>
            
            <time start="2014-04-07T06:00:00+08:00" end="2014-04-07T18:00:00+08:00">
                <text>陰時多雲短暫陣雨</text>
                <value>26</value>
            </time>
            
            <time start="2014-04-07T18:00:00+08:00" end="2014-04-08T06:00:00+08:00">
                <text>多雲短暫陣雨</text>
                <value>12</value>
                </time>
        </Wx>
        <MaxT>
            <time start="2014-04-06T18:00:00+08:00" end="2014-04-07T06:00:00+08:00">
                <value units="C">21</value>
            </time>
            <time start="2014-04-07T06:00:00+08:00" end="2014-04-07T18:00:00+08:00">
                <value units="C">24</value>
            </time>
            <time start="2014-04-07T18:00:00+08:00" end="2014-04-08T06:00:00+08:00">
                <value units="C">22</value>
            </time>
        </MaxT>

        <MinT>
            <time start="2014-04-06T18:00:00+08:00" end="2014-04-07T06:00:00+08:00">
                <value units="C">20</value>
            </time>
            <time start="2014-04-07T06:00:00+08:00" end="2014-04-07T18:00:00+08:00">
                <value units="C">20</value>
            </time>
            <time start="2014-04-07T18:00:00+08:00" end="2014-04-08T06:00:00+08:00">
                <value units="C">19</value>
            </time>
        </MinT>

        <CI>
            <time start="2014-04-06T18:00:00+08:00" end="2014-04-07T06:00:00+08:00">
                <text>稍有寒意至舒適</text>
            </time>
            <time start="2014-04-07T06:00:00+08:00" end="2014-04-07T18:00:00+08:00">
                <text>稍有寒意至舒適</text>
            </time>
            <time start="2014-04-07T18:00:00+08:00" end="2014-04-08T06:00:00+08:00">
                <text>稍有寒意至舒適</text>
            </time>
        </CI>

        <PoP>
            <time start="2014-04-06T18:00:00+08:00" end="2014-04-07T06:00:00+08:00">
                <value units="%">30</value>
            </time>
            <time start="2014-04-07T06:00:00+08:00" end="2014-04-07T18:00:00+08:00">
                <value units="%">50</value>
            </time>
            <time start="2014-04-07T18:00:00+08:00" end="2014-04-08T06:00:00+08:00">
                <value units="%">30</value>
            </time>
        </PoP>
    </weather-elements>
</location>
</data>
</fifowml>



ViewController
====================
LocationTVC : UITableViewController
顯示地點的城市名稱


LocationDetailVC: UIViewController
顯示地點的天氣詳細預報

