<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Converter.aspx.cs" Inherits="OneStopStudentSystem.Converter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        input {
            width: 200px;
            height: 24px;
        }

        select {
            width: 200px;
            height: 24px;
        }

        button {
            background-color:#68565B ;
            border-style:Solid;
            height:55px;
            width: 184px;
            border-radius: 10px;
            color:white;
        }

        div.result {
            width: 2270px;
        }
        .auto-style15 {
            width: 2270px;
        }
        .auto-style16 {
            width: 200px;
            height: 29px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%; margin-left:200px">
        <tr>
            <td class="auto-style15">
                <asp:Label ID="Label17" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Unit Converter" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">
                <label for="category">Select Category:</label>
                <select id="category" onchange="changeCategory()" class="auto-style16">
                    <option value=""><--Select a category--></option>
                    <option value="length">Length</option>
                    <option value="weight">Weight and Mass</option>
                    <option value="volume">Volume</option>
                    <option value="temperature">Temperature</option>
                    <option value="area">Area</option>
                    <option value="speed">Speed</option>
                    <option value="time">Time</option>
                    <option value="pressure">Pressure</option>
                    <option value="energy">Energy</option>
                    <option value="power">Power</option>
                    <option value="force">Force</option>
                    <option value="angle">Angle</option>
                    <option value="numbers">Base</option>
                    <option value="case">Case</option>
                    <option value="calculator">Calculator</option>
                </select>
                 <br><br>
                <div id="calculator" style="display: none;">
                    <label for="base">Select Base:</label>
                    <select id="base" onchange="changeBase()">
                        <option value="2">Binary</option>
                        <option value="8">Octal</option>
                        <option value="10" selected>Decimal</option>
                        <option value="16">Hexadecimal</option>
                    </select>
                     <br>
                    <br>
                    <label for="number1">Number 1:</label>
                    <input type="text" id="number1">

                    <label for="operator">Operator:</label>
                    <select id="operator">
                        <option value="+">+</option>
                        <option value="-">-</option>
                        <option value="*">*</option>
                        <option value="/">/</option>
                    </select>
                    <br> <br>
                    <label for="number2">Number 2:</label>
                    <input type="text" id="number2">
                     <br><br>
                    <button type="button" onclick="calculate()">Calculate</button>
                    <div id="calculatorResult" class="result">
                    </div>
                </div>

                <div id="numbers" style="display: none;">
                    <h2>Base Conversion</h2>
                    <label for="numberValue">Enter Value:</label>
                    <input type="text" id="numberValue">
                    <select id="numbersUnit">
                        <option value="binary">Binary</option>
                        <option value="octal">Octal</option>
                        <option value="decimal">Decimal</option>
                        <option value="hexadecimal">Hexadecimal</option>
                        <option value="base2">Base-2</option>
                        <option value="base3">Base-3</option>
                        <option value="base4">Base-4</option>
                        <option value="base5">Base-5</option>
                        <option value="base6">Base-6</option>
                        <option value="base7">Base-7</option>
                        <option value="base8">Base-8</option>
                        <option value="base9">Base-9</option>
                        <option value="base10">Base-10</option>
                        <option value="base11">Base-11</option>
                        <option value="base12">Base-12</option>
                        <option value="base13">Base-13</option>
                        <option value="base14">Base-14</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="numberNotation">
                        <option value="ndefault" default>Default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>
                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="numberDecimalPlaces" value="2">
                    <button type="button" onclick="convertNumbers()">Convert</button>
                    <div id="numbersResult" class="result"></div>
                </div>

                <div id="case" style="display: none;">
                    <h2>Case Converter</h2>
                    <label for="textInput">Enter Text:</label>
                    <textarea id="textInput" rows="4" cols="50"></textarea>
                    <br />
                    <label for="conversionType">Conversion Type:</label>
                    <select id="conversionType">
                        <option value="upperCase">UPPER CASE</option>
                        <option value="lowerCase">lower case</option>
                        <option value="titleCase">Title Case(except prepositions, conjunction, articles)</option>
                        <option value="sentenceCase">Sentence case</option>
                        <option value="capitalizedCase">Capitalized Case</option>
                        <option value="inverseCase">Inverse Case</option>
                        <option value="normalizedSingleSpace">Normalized with Single Space</option>
                        <option value="normalizedDoubleSpace">Normalized with Double Space</option>
                        <option value="inverseString">Inverse String</option>
                    </select>
                    <button type="button" onclick="convertText()">Convert</button>
                    <div id="convertedText" class="result"></div>
                </div>

                <div id="angle" style="display: none;">
                    <h2>Angle Conversion</h2>
                    <label for="angleValue">Enter Value:</label>
                    <input type="number" id="angleValue">
                    <select id="angleUnit">
                        <option value="degree">Degree (°)</option>
                        <option value="radian">Radian (rad)</option>
                        <option value="gradian">Gradian (grad)</option>
                        <option value="revolution">Revolution (rev)</option>
                        <option value="minute">Minute (&#39;)</option>
                        <option value="second">Second (&#39;&#39;)</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="angleNotation">
                        <option value="ndefault" default>Default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>
                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="angleDecimalPlaces" value="2">
                    <button type="button" onclick="convertAngle()">Convert</button>
                    <div id="angleResult" class="result"></div>
                </div>

                <div id="force" style="display: none;">
                    <h2>Force Conversion</h2>
                    <label for="forceValue">Enter Value:</label>
                    <input type="number" id="forceValue">
                    <select id="forceUnit">
                        <option value="newton">Newton (N)</option>
                        <option value="kilonewton">Kilonewton (kN)</option>
                        <option value="millinewton">Millinewton (mN)</option>
                        <option value="microNewton">MicroNewton (µN)</option>
                        <option value="dyne">Dyne (dyn)</option>
                        <option value="poundForce">Pound-force (lbf)</option>
                        <option value="ounceForce">Ounce-force (ozf)</option>
                        <option value="gramForce">Gram-force (gf)</option>
                        <option value="kilogramForce">Kilogram-force (kgf)</option>
                        <option value="kilopoundForce">Kilopound-force (kip)</option>
                        <option value="tonForce">Ton-force</option>
                        <option value="jourlePerMeter">Joule/meter (J/m)</option>
                        <option value="jourlePerCentimeter">Joule/centimeter (J/cm)</option>
                        <option value="kipForce">kip-force (kipf)</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="forceNotation">
                        <option value="ndefault" default>Default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>
                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="forceDecimalPlaces" value="9">
                    <button type="button" onclick="convertForce()">Convert</button>
                    <div id="forceResult" class="result"></div>
                </div>

                <div id="pressure" style="display: none;">
                    <h2>Pressure Conversion</h2>
                    <label for="pressureValue">Enter Value:</label>
                    <input type="number" id="pressureValue">
                    <select id="pressureUnit">
                        <option value="pascal">Pascal (Pa)</option>
                        <option value="kilopascal">Kilopascal (kPa)</option>
                        <option value="megapascal">Megapascal (MPa)</option>
                        <option value="gigapascal">Gigapascal (GPa)</option>
                        <option value="atmosphere">Atmosphere (atm)</option>
                        <option value="bar">Bar</option>
                        <option value="millibar">Millibar (mbar)</option>
                        <option value="microbar">Microbar (µbar)</option>
                        <option value="millimeterOfMercury">Millimeter of Mercury (mmHg)</option>
                        <option value="inchOfMercury">Inch of Mercury (inHg)</option>
                        <option value="poundPerSquareInch">Pound per Square Inch (psi)</option>
                        <option value="ksi">Kilopound per Square Inch (ksi)</option>
                        <option value="torr">Torr</option>
                        <option value="centimeterOfWater">Centimeter of Water (cmH₂O)</option>
                        <option value="millimeterOfWater">Millimeter of Water (mmH₂O)</option>
                        <option value="kilogramPerSquareMeter">Kilogram-force per Square Meter (kg/cm²)</option>
                        <option value="kilogramPerSquareCentimeter">Kilogram-force per Square Centimeter (kg/cm²)</option>
                        <option value="kilogramPerSquareMillimeter">Kilogram-force per Square Millimeter (kg/mm²)</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="pressureNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="pressureDecimalPlaces" value="9">
                    <button type="button" onclick="convertPressure()">Convert</button>
                    <div id="pressureResult" class="result"></div>
                </div>

                <div id="power" style="display: none;">
                    <h2>Power Conversion</h2>
                    <label for="powerValue">Enter Value:</label>
                    <input type="number" id="powerValue">
                    <select id="powerUnit">
                        <option value="watt">Watt (W)</option>
                        <option value="kilowatt">Kilowatt (kW)</option>
                        <option value="megawatt">Megawatt (MW)</option>
                        <option value="gigawatt">Gigawatt (GW)</option>
                        <option value="horsepower">Horsepower (hp)</option>
                        <option value="metricHorsepower">Metric Horsepower</option>
                        <option value="electricalHorsepower">Electrical Horsepower</option>
                        <option value="boilerHorsepower">Boiler Horsepower</option>
                        <option value="footPoundPerSecond">Foot-Pound/Second</option>
                        <option value="footPoundPerMinute">Foot-Pound/Minute</option>
                        <option value="footPoundPerHour">Foot-Pound/Hour</option>
                        <option value="caloriePerSecond">Calorie/Second (cal/s)</option>
                        <option value="caloriePerMinute">Calorie/Minute (cal/min)</option>
                        <option value="caloriePerHour">Calorie/Hour (cal/hour)</option>
                        <option value="voltAmpere">Volt Ampere (VA)</option>
                        <option value="kilovoltAmpere">Kilovolt Ampere (kVA)</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="powerNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="powerDecimalPlaces" value="9">
                    <button type="button" onclick="convertPower()">Convert</button>
                    <div id="powerResult" class="result"></div>
                </div>

                <div id="energy" style="display: none;">
                    <h2>Energy Conversion</h2>
                    <label for="energyValue">Enter Value:</label>
                    <input type="number" id="energyValue">
                    <select id="energyUnit">
                        <option value="joule">Joule (J)</option>
                        <option value="kilojoule">Kilojoule (kJ)</option>
                        <option value="kilowattHour">Kilowatt-hour (kWh)</option>
                        <option value="wattHour">Watt-hour (Wh)</option>
                        <option value="calorie">Calorie (cal)</option>
                        <option value="kilocalorie">Kilocalorie (kcal)</option>
                        <option value="electronVolt">Electron-volt (eV)</option>
                        <option value="kielectronVolt">kiloelectron-volt (keV)</option>
                        <option value="hartreeEnergy">Hartree Energy</option>
                        <option value="rydbergConstant">Rydberg Constant</option>
                    </select>

                    <br>
                    <label for="notation">Notation:</label>
                    <select id="energyNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="energyDecimalPlaces" value="9">
                    <button type="button" onclick="convertEnergy()">Convert</button>
                    <div id="energyResult" class="result"></div>
                </div>

                <div id="speed" style="display: none;">
                    <h2>Speed Conversion</h2>
                    <label for="speedValue">Enter Value:</label>
                    <input type="number" id="speedValue">
                    <select id="speedUnit">
                        <option value="meterPerSecond">Meter/Second (m/s)</option>
                        <option value="meterPerMinute">Meter/Minute (m/min)</option>
                        <option value="meterPerHour">Meter/Hour (m/h)</option>
                        <option value="kilometerPerSecond">Kilometer/Second (km/s)</option>
                        <option value="kilometerPerMinute">Kilometer/Minute (km/min)</option>
                        <option value="kilometerPerHour">Kilometer/Hour (km/h)</option>
                        <option value="centimeterPerSecond">Centimeter/Second (cm/s)</option>
                        <option value="centimeterPerMinute">Centimeter/Minute (cm/min)</option>
                        <option value="centimeterPerHour">Centimeter/Hour (cm/h)</option>
                        <option value="millimeterPerSecond">Millimeter/Second (mm/s)</option>
                        <option value="millimeterPerMinute">Millimeter/Minute (mm/min)</option>
                        <option value="millimeterPerHour">Millimeter/Hour (mm/h)</option>
                        <option value="milePerSecond">Mile/Second (mi/s)</option>
                        <option value="milePerMinute">Mile/Minute (mi/min)</option>
                        <option value="milePerHour">Mile/Hour (mi/h)</option>
                        <option value="knot">Knot (kn)</option>
                        <option value="speedOfLight">Speed of Light in Vacuum</option>
                        <option value="speedOfSound">Speed of Sound in Dry Air</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="speedNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="speedDecimalPlaces" value="9">
                    <button type="button" onclick="convertSpeed()">Convert</button>
                    <div id="speedResult" class="result"></div>
                </div>


                <div id="volume" style="display: none;">
                    <h2>Volume Conversion</h2>
                    <label for="volumeValue">Enter Value:</label>
                    <input type="number" id="volumeValue">
                    <select id="volumeUnit">
                        <option value="cubicMeter">Cubic Meter (m³)</option>
                        <option value="cubicKilometer">Cubic Kilometer (km³)</option>
                        <option value="cubicCentimeter">Cubic Centimeter (cm³)</option>
                        <option value="cubicMillimeter">Cubic Millimeter (mm³)</option>
                        <option value="cubicDecimeter">Cubic Decimeter (dm³)</option>
                        <option value="liter">Liter (L)</option>
                        <option value="milliliter">Milliliter (ml)</option>
                        <option value="gallon">Gallon (gal)</option>
                        <option value="quart">Quart (qt)</option>
                        <option value="pint">Pint (pt)</option>
                        <option value="cup">Cup</option>
                        <option value="fluidOunce">Fluid Ounce (fl oz)</option>
                        <option value="tablespoon">Tablespoon</option>
                        <option value="teaspoon">Teaspoon</option>
                        <option value="earthVolume">Earth's Volume</option>

                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="volumeNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="volumeDecimalPlaces" value="9">
                    <button type="button" onclick="convertVolume()">Convert</button>
                    <div id="volumeResult" class="result"></div>
                </div>

                <div id="temperature" style="display: none;">
                    <h2>Temperature Conversion</h2>
                    <label for="tempValue">Enter Value:</label>
                    <input type="number" id="tempValue">
                    <select id="tempUnit">
                        <option value="celsius">Celsius (°C)</option>
                        <option value="kelvin">Kelvin (K)</option>
                        <option value="fahrenheit">Fahrenheit (°F)</option>
                        <option value="rankine">Rankine (°R)</option>
                        <option value="reaumur">Reaumur (°Re)</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="tempNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="tempDecimalPlaces" value="9">
                    <button type="button" onclick="convertTemperature()">Convert</button>
                    <div id="tempResult" class="result"></div>
                </div>

                <div id="area" style="display: none;">
                    <h2>Area Conversion</h2>
                    <label for="areaValue">Enter Value:</label>
                    <input type="number" id="areaValue">
                    <select id="areaUnit">
                        <option value="squareMeter">Square Meter (m²)</option>
                        <option value="squareKilometer">Square Kilometer (km²)</option>
                        <option value="squareCentimeter">Square Centimeter (cm²)</option>
                        <option value="squareMillimeter">Square Millimeter (mm²)</option>
                        <option value="squareMicrometer">Square Micrometer (µm²)</option>
                        <option value="acre">Acre (ac)</option>
                        <option value="hectare">Hectare (ha)</option>
                        <option value="squareMile">Square Mile (mi²)</option>
                        <option value="squareYard">Square Yard (yd²)</option>
                        <option value="squareFoot">Square Foot (ft²)</option>
                        <option value="squareInch">Square Inch (in²)</option>
                        <option value="squareHectometer">Square Hectometer (hm²)</option>
                        <option value="squareDekameter">Square Dekameter (dam²)</option>
                        <option value="squareDecimeter">Square Decimeter (dm²)</option>
                        <option value="squareNanometer">Square Nanometer (nm²)</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="areaNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="areaDecimalPlaces" value="9">
                    <button type="button" onclick="convertArea()">Convert</button>
                    <div id="areaResult" class="result"></div>
                </div>

                <div id="weight" style="display: none;">
                    <h2>Weight and Mass Conversion</h2>
                    <label for="weightValue">Enter Value:</label>
                    <input type="number" id="weightValue">
                    <select id="weightUnit">
                        <option value="gram">Gram (g)</option>
                        <option value="kilogram">Kilogram (kg)</option>
                        <option value="milligram">Milligram (mg)</option>
                        <option value="decigram">Decigram (dg)</option>
                        <option value="centigram">Centigram (cg)</option>
                        <option value="metricTon">Metric Ton (t)</option>
                        <option value="longTon">Long Ton</option>
                        <option value="shortTon">Short Ton</option>
                        <option value="pound">Pound (lbs)</option>
                        <option value="ounce">Ounce (oz)</option>
                        <option value="carat">Carat (ct)</option>
                        <option value="atomicMassUnit">Atomic Mass Unit (u)</option>
                        <option value="dalton">Dalton (Da)</option>
                        <option value="gamma">Gamma (&#120574;)</option>
                        <option value="planckMass">Planck Mass</option>
                        <option value="electronMass">Electron Mass</option>
                        <option value="muonMass">Muon Mass</option>
                        <option value="protonMass">Proton Mass</option>
                        <option value="neutronMass">Neutron Mass</option>
                        <option value="deuteronMass">Deuteron Mass</option>
                        <option value="earthMass">Earth's Mass</option>
                        <option value="sunMass">Sun's Mass</option>
                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="weightNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="weightDecimalPlaces" value="9">
                    <button type="button" onclick="convertWeight()">Convert</button>
                    <div id="weightResult" class="result"></div>
                </div>

                <div id="length" style="display: none;">
                    <h2>Length Conversion</h2>
                    <label for="lengthValue">Enter Value:</label>
                    <input type="number" id="lengthValue">
                    <select id="lengthUnit">
                        <option value="meter">Meter (m)</option>
                        <option value="kilometer">Kilometer (km)</option>
                        <option value="decimeter">Decimeter (dm)</option>
                        <option value="centimeter">Centimeter (cm)</option>
                        <option value="millimeter">Millimeter (mm)</option>
                        <option value="micrometer">Micrometer (µm)</option>
                        <option value="nanometer">Nanometer (nm)</option>
                        <option value="mile">Mile (mi)</option>
                        <option value="yard">Yard (yd)</option>
                        <option value="foot">Foot (ft)</option>
                        <option value="inch">Inch (in)</option>
                        <option value="planckLength">Planck Length</option>
                        <option value="electronRadius">Electron Radius</option>
                        <option value="bohrRadius">Bohr Radius</option>
                        <option value="earthEquatorialRadius">Earth's Equatorial Radius</option>
                        <option value="earthPolarRadius">Earth's Polar Radius</option>
                        <option value="earthDistanceFromSun">Earth's Distance from Sun</option>
                        <option value="sunRadius">Sun Radius</option>

                    </select>
                    <br />
                    <label for="notation">Notation:</label>
                    <select id="lengthNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="lengthDecimalPlaces" value="9">
                    <button type="button" onclick="convertLength()">Convert</button>
                    <div id="lengthResult" class="result"></div>
                </div>

                <div id="time" style="display: none;">
                    <h2>Time Conversion</h2>
                    <label for="timeValue">Enter Value:</label>
                    <input type="number" id="timeValue">
                    <select id="timeUnit">
                        <option value="second">Second (s)</option>
                        <option value="millisecond">Millisecond (ms)</option>
                        <option value="minute">Minute (min)</option>
                        <option value="hour">Hour (h)</option>
                        <option value="day">Day (d)</option>
                        <option value="week">Week</option>
                        <option value="month">Month</option>
                        <option value="year">Year (y)</option>
                        <option value="decade">Decade</option>
                        <option value="century">Century</option>
                    </select>

                    <br />
                    <label for="notation">Notation:</label>
                    <select id="timeNotation">
                        <option value="ndefault" default>default</option>
                        <option value="normal">Normal</option>
                        <option value="exponential">Exponential</option>
                    </select>

                    <label for="decimalPlaces">Decimal Places:</label>
                    <input type="number" id="timeDecimalPlaces" value="9">

                    <button type="button" onclick="convertTime()">Convert</button>
                    <div id="timeResult" class="result"></div>
                </div>



                <script>
                    //-------------------------------------------------------
                    function changeCategory() {
                        // Hide all conversion sections
                        document.getElementById("temperature").style.display = "none";
                        document.getElementById("area").style.display = "none";
                        document.getElementById("weight").style.display = "none";
                        document.getElementById("length").style.display = "none";
                        document.getElementById("time").style.display = "none";
                        document.getElementById("volume").style.display = "none";
                        document.getElementById("speed").style.display = "none";
                        document.getElementById("energy").style.display = "none";
                        document.getElementById("pressure").style.display = "none";
                        document.getElementById("power").style.display = "none";
                        document.getElementById("force").style.display = "none";
                        document.getElementById("angle").style.display = "none";
                        document.getElementById("numbers").style.display = "none";
                        document.getElementById("case").style.display = "none";
                        document.getElementById("calculator").style.display = "none";
                        // Show the selected conversion section
                        var selectedCategory = document.getElementById("category").value;
                        document.getElementById(selectedCategory).style.display = "block";
                    }

                    function changeBase() {
                        // Reset the calculator result when the base changes
                        document.getElementById("calculatorResult").innerHTML = "";
                    }

                    function calculate() {
                        // Get user input
                        var base = parseInt(document.getElementById("base").value);
                        var number1 = document.getElementById("number1").value;
                        var number2 = document.getElementById("number2").value;
                        var operator = document.getElementById("operator").value;

                        // Convert input numbers to decimal for calculation
                        var decimalNumber1 = parseInt(number1, base);
                        var decimalNumber2 = parseInt(number2, base);

                        // Perform the calculation in decimal
                        var resultDecimal;
                        switch (operator) {
                            case "+":
                                resultDecimal = decimalNumber1 + decimalNumber2;
                                break;
                            case "-":
                                resultDecimal = decimalNumber1 - decimalNumber2;
                                break;
                            case "*":
                                resultDecimal = decimalNumber1 * decimalNumber2;
                                break;
                            case "/":
                                if (decimalNumber2 !== 0) {
                                    resultDecimal = decimalNumber1 / decimalNumber2;
                                } else {
                                    document.getElementById("calculatorResult").innerHTML = "Cannot divide by zero.";
                                    return;
                                }
                                break;
                            default:
                                document.getElementById("calculatorResult").innerHTML = "Invalid operator.";
                                return;
                        }

                        // Convert the result back to the selected base
                        var resultBase = resultDecimal.toString(base);

                        // Display the result
                        document.getElementById("calculatorResult").innerHTML = "Result: " + resultBase.toUpperCase();
                    }

                    function convertNumbers() {
                        // Get user input
                        var numberValue = document.getElementById("numberValue").value;
                        var numbersUnit = document.getElementById("numbersUnit").value;
                        var notation = document.getElementById("numberNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("numberDecimalPlaces").value);

                        // Perform input validation based on the selected unit
                        var isValidInput = validateInput(numberValue, numbersUnit);
                        if (!isValidInput) {
                            document.getElementById("numbersResult").innerHTML = "Invalid input value. Please enter a valid value for " + numbersUnit;
                            return; // Exit the function if input is invalid
                        }
                        // Perform the conversion
                        var result;
                        switch (numbersUnit) {
                            case "decimal":
                                result = {
                                    decimal: parseFloat(numberValue),
                                    binary: (parseFloat(numberValue)).toString(2),
                                    octal: (parseFloat(numberValue)).toString(8),
                                    hexadecimal: (parseFloat(numberValue)).toString(16).toUpperCase(),
                                    base2: (parseFloat(numberValue)).toString(2),
                                    base3: (parseFloat(numberValue)).toString(3),
                                    base4: (parseFloat(numberValue)).toString(4),
                                    base5: (parseFloat(numberValue)).toString(5),
                                    base6: (parseFloat(numberValue)).toString(6),
                                    base7: (parseFloat(numberValue)).toString(7),
                                    base8: (parseFloat(numberValue)).toString(8),
                                    base9: (parseFloat(numberValue)).toString(9),
                                    base10: (parseFloat(numberValue)).toString(10),
                                    base11: (parseFloat(numberValue)).toString(11).toUpperCase(),
                                    base12: (parseFloat(numberValue)).toString(12).toUpperCase(),
                                    base13: (parseFloat(numberValue)).toString(13).toUpperCase(),
                                    base14: (parseFloat(numberValue)).toString(14).toUpperCase()
                                };
                                break;
                            case "binary":
                                result = {
                                    decimal: parseInt(numberValue, 2),
                                    binary: numberValue,
                                    octal: (parseInt(numberValue, 2)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 2)).toString(16).toUpperCase(),
                                    base2: numberValue,
                                    base3: (parseInt(numberValue, 2)).toString(3),
                                    base4: (parseInt(numberValue, 2)).toString(4),
                                    base5: (parseInt(numberValue, 2)).toString(5),
                                    base6: (parseInt(numberValue, 2)).toString(6),
                                    base7: (parseInt(numberValue, 2)).toString(7),
                                    base8: (parseInt(numberValue, 2)).toString(8),
                                    base9: (parseInt(numberValue, 2)).toString(9),
                                    base10: (parseInt(numberValue, 2)).toString(10),
                                    base11: (parseInt(numberValue, 2)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 2)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 2)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 2)).toString(14).toUpperCase()
                                };
                                break;
                            case "octal":
                                result = {
                                    decimal: parseInt(numberValue, 8),
                                    binary: (parseInt(numberValue, 8)).toString(2),
                                    octal: numberValue,
                                    hexadecimal: (parseInt(numberValue, 8)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 8)).toString(2),
                                    base3: (parseInt(numberValue, 8)).toString(3),
                                    base4: (parseInt(numberValue, 8)).toString(4),
                                    base5: (parseInt(numberValue, 8)).toString(5),
                                    base6: (parseInt(numberValue, 8)).toString(6),
                                    base7: (parseInt(numberValue, 8)).toString(7),
                                    base8: (parseInt(numberValue, 8)).toString(8),
                                    base9: (parseInt(numberValue, 8)).toString(9),
                                    base10: (parseInt(numberValue, 8)).toString(10),
                                    base11: (parseInt(numberValue, 8)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 8)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 8)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 8)).toString(14).toUpperCase()
                                };
                                break;
                            case "hexadecimal":
                                result = {
                                    decimal: parseInt(numberValue, 16),
                                    binary: (parseInt(numberValue, 16)).toString(2),
                                    octal: (parseInt(numberValue, 16)).toString(8),
                                    hexadecimal: numberValue.toUpperCase(),
                                    base2: (parseInt(numberValue, 16)).toString(2),
                                    base3: (parseInt(numberValue, 16)).toString(3),
                                    base4: (parseInt(numberValue, 16)).toString(4),
                                    base5: (parseInt(numberValue, 16)).toString(5),
                                    base6: (parseInt(numberValue, 16)).toString(6),
                                    base7: (parseInt(numberValue, 16)).toString(7),
                                    base8: (parseInt(numberValue, 16)).toString(8),
                                    base9: (parseInt(numberValue, 16)).toString(9),
                                    base10: (parseInt(numberValue, 16)).toString(10),
                                    base11: (parseInt(numberValue, 16)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 16)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 16)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 16)).toString(14).toUpperCase()
                                };
                                break;
                            case "base2":
                                result = {
                                    decimal: parseInt(numberValue, 2),
                                    binary: numberValue,
                                    octal: (parseInt(numberValue, 2)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 2)).toString(16).toUpperCase(),
                                    base2: numberValue,
                                    base3: (parseInt(numberValue, 2)).toString(3),
                                    base4: (parseInt(numberValue, 2)).toString(4),
                                    base5: (parseInt(numberValue, 2)).toString(5),
                                    base6: (parseInt(numberValue, 2)).toString(6),
                                    base7: (parseInt(numberValue, 2)).toString(7),
                                    base8: (parseInt(numberValue, 2)).toString(8),
                                    base9: (parseInt(numberValue, 2)).toString(9),
                                    base10: (parseInt(numberValue, 2)).toString(10),
                                    base11: (parseInt(numberValue, 2)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 2)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 2)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 2)).toString(14).toUpperCase()
                                };
                                break;
                            case "base3":
                                result = {
                                    decimal: parseInt(numberValue, 3),
                                    binary: (parseInt(numberValue, 3)).toString(2),
                                    octal: (parseInt(numberValue, 3)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 3)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 3)).toString(2),
                                    base3: numberValue,
                                    base4: (parseInt(numberValue, 3)).toString(4),
                                    base5: (parseInt(numberValue, 3)).toString(5),
                                    base6: (parseInt(numberValue, 3)).toString(6),
                                    base7: (parseInt(numberValue, 3)).toString(7),
                                    base8: (parseInt(numberValue, 3)).toString(8),
                                    base9: (parseInt(numberValue, 3)).toString(9),
                                    base10: (parseInt(numberValue, 3)).toString(10),
                                    base11: (parseInt(numberValue, 3)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 3)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 3)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 3)).toString(14).toUpperCase()
                                };
                                break;
                            case "base4":
                                result = {
                                    decimal: parseInt(numberValue, 4),
                                    binary: (parseInt(numberValue, 4)).toString(2),
                                    octal: (parseInt(numberValue, 4)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 4)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 4)).toString(2),
                                    base3: (parseInt(numberValue, 4)).toString(3),
                                    base4: numberValue,
                                    base5: (parseInt(numberValue, 4)).toString(5),
                                    base6: (parseInt(numberValue, 4)).toString(6),
                                    base7: (parseInt(numberValue, 4)).toString(7),
                                    base8: (parseInt(numberValue, 4)).toString(8),
                                    base9: (parseInt(numberValue, 4)).toString(9),
                                    base10: (parseInt(numberValue, 4)).toString(10),
                                    base11: (parseInt(numberValue, 4)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 4)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 4)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 4)).toString(14).toUpperCase()
                                };
                                break;
                            case "base5":
                                result = {
                                    decimal: parseInt(numberValue, 5),
                                    binary: (parseInt(numberValue, 5)).toString(2),
                                    octal: (parseInt(numberValue, 5)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 5)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 5)).toString(2),
                                    base3: (parseInt(numberValue, 5)).toString(3),
                                    base4: (parseInt(numberValue, 5)).toString(4),
                                    base5: numberValue,
                                    base6: (parseInt(numberValue, 5)).toString(6),
                                    base7: (parseInt(numberValue, 5)).toString(7),
                                    base8: (parseInt(numberValue, 5)).toString(8),
                                    base9: (parseInt(numberValue, 5)).toString(9),
                                    base10: (parseInt(numberValue, 5)).toString(10),
                                    base11: (parseInt(numberValue, 5)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 5)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 5)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 5)).toString(14).toUpperCase()
                                };
                                break;
                            case "base6":
                                result = {
                                    decimal: parseInt(numberValue, 6),
                                    binary: (parseInt(numberValue, 6)).toString(2),
                                    octal: (parseInt(numberValue, 6)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 6)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 6)).toString(2),
                                    base3: (parseInt(numberValue, 6)).toString(3),
                                    base4: (parseInt(numberValue, 6)).toString(4),
                                    base5: (parseInt(numberValue, 6)).toString(5),
                                    base6: numberValue,
                                    base7: (parseInt(numberValue, 6)).toString(7),
                                    base8: (parseInt(numberValue, 6)).toString(8),
                                    base9: (parseInt(numberValue, 6)).toString(9),
                                    base10: (parseInt(numberValue, 6)).toString(10),
                                    base11: (parseInt(numberValue, 6)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 6)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 6)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 6)).toString(14).toUpperCase()
                                };
                                break;
                            case "base7":
                                result = {
                                    decimal: parseInt(numberValue, 7),
                                    binary: (parseInt(numberValue, 7)).toString(2),
                                    octal: (parseInt(numberValue, 7)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 7)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 7)).toString(2),
                                    base3: (parseInt(numberValue, 7)).toString(3),
                                    base4: (parseInt(numberValue, 7)).toString(4),
                                    base5: (parseInt(numberValue, 7)).toString(5),
                                    base6: (parseInt(numberValue, 7)).toString(6),
                                    base7: numberValue,
                                    base8: (parseInt(numberValue, 7)).toString(8),
                                    base9: (parseInt(numberValue, 7)).toString(9),
                                    base10: (parseInt(numberValue, 7)).toString(10),
                                    base11: (parseInt(numberValue, 7)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 7)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 7)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 7)).toString(14).toUpperCase()
                                };
                                break;
                            case "base8":
                                result = {
                                    decimal: parseInt(numberValue, 8),
                                    binary: (parseInt(numberValue, 8)).toString(2),
                                    octal: numberValue,
                                    hexadecimal: (parseInt(numberValue, 8)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 8)).toString(2),
                                    base3: (parseInt(numberValue, 8)).toString(3),
                                    base4: (parseInt(numberValue, 8)).toString(4),
                                    base5: (parseInt(numberValue, 8)).toString(5),
                                    base6: (parseInt(numberValue, 8)).toString(6),
                                    base7: (parseInt(numberValue, 8)).toString(7),
                                    base8: numberValue,
                                    base9: (parseInt(numberValue, 8)).toString(9),
                                    base10: (parseInt(numberValue, 8)).toString(10),
                                    base11: (parseInt(numberValue, 8)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 8)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 8)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 8)).toString(14).toUpperCase()
                                };
                                break;
                            case "base9":
                                result = {
                                    decimal: parseInt(numberValue, 9),
                                    binary: (parseInt(numberValue, 9)).toString(2),
                                    octal: (parseInt(numberValue, 9)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 9)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 9)).toString(2),
                                    base3: (parseInt(numberValue, 9)).toString(3),
                                    base4: (parseInt(numberValue, 9)).toString(4),
                                    base5: (parseInt(numberValue, 9)).toString(5),
                                    base6: (parseInt(numberValue, 9)).toString(6),
                                    base7: (parseInt(numberValue, 9)).toString(7),
                                    base8: (parseInt(numberValue, 9)).toString(8),
                                    base9: numberValue,
                                    base10: (parseInt(numberValue, 9)).toString(10),
                                    base11: (parseInt(numberValue, 9)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 9)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 9)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 9)).toString(14).toUpperCase()
                                };
                                break;
                            case "base10":
                                result = {
                                    decimal: parseFloat(numberValue),
                                    binary: (parseFloat(numberValue)).toString(2),
                                    octal: (parseFloat(numberValue)).toString(8),
                                    hexadecimal: (parseFloat(numberValue)).toString(16).toUpperCase(),
                                    base2: (parseFloat(numberValue)).toString(2),
                                    base3: (parseFloat(numberValue)).toString(3),
                                    base4: (parseFloat(numberValue)).toString(4),
                                    base5: (parseFloat(numberValue)).toString(5),
                                    base6: (parseFloat(numberValue)).toString(6),
                                    base7: (parseFloat(numberValue)).toString(7),
                                    base8: (parseFloat(numberValue)).toString(8),
                                    base9: (parseFloat(numberValue)).toString(9),
                                    base10: numberValue,
                                    base11: (parseFloat(numberValue)).toString(11).toUpperCase(),
                                    base12: (parseFloat(numberValue)).toString(12).toUpperCase(),
                                    base13: (parseFloat(numberValue)).toString(13).toUpperCase(),
                                    base14: (parseFloat(numberValue)).toString(14).toUpperCase()
                                };
                                break;
                            case "base11":
                                result = {
                                    decimal: parseInt(numberValue, 11),
                                    binary: (parseInt(numberValue, 11)).toString(2),
                                    octal: (parseInt(numberValue, 11)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 11)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 11)).toString(2),
                                    base3: (parseInt(numberValue, 11)).toString(3),
                                    base4: (parseInt(numberValue, 11)).toString(4),
                                    base5: (parseInt(numberValue, 11)).toString(5),
                                    base6: (parseInt(numberValue, 11)).toString(6),
                                    base7: (parseInt(numberValue, 11)).toString(7),
                                    base8: (parseInt(numberValue, 11)).toString(8),
                                    base9: (parseInt(numberValue, 11)).toString(9),
                                    base10: (parseInt(numberValue, 11)).toString(10),
                                    base11: numberValue.toUpperCase(),
                                    base12: (parseInt(numberValue, 11)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 11)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 11)).toString(14).toUpperCase()
                                };
                                break;
                            case "base12":
                                result = {
                                    decimal: parseInt(numberValue, 12),
                                    binary: (parseInt(numberValue, 12)).toString(2),
                                    octal: (parseInt(numberValue, 12)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 12)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 12)).toString(2),
                                    base3: (parseInt(numberValue, 12)).toString(3),
                                    base4: (parseInt(numberValue, 12)).toString(4),
                                    base5: (parseInt(numberValue, 12)).toString(5),
                                    base6: (parseInt(numberValue, 12)).toString(6),
                                    base7: (parseInt(numberValue, 12)).toString(7),
                                    base8: (parseInt(numberValue, 12)).toString(8),
                                    base9: (parseInt(numberValue, 12)).toString(9),
                                    base10: (parseInt(numberValue, 12)).toString(10),
                                    base11: (parseInt(numberValue, 12)).toString(11).toUpperCase(),
                                    base12: numberValue.toUpperCase(),
                                    base13: (parseInt(numberValue, 12)).toString(13).toUpperCase(),
                                    base14: (parseInt(numberValue, 12)).toString(14).toUpperCase()
                                };
                                break;
                            case "base13":
                                result = {
                                    decimal: parseInt(numberValue, 13),
                                    binary: (parseInt(numberValue, 13)).toString(2),
                                    octal: (parseInt(numberValue, 13)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 13)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 13)).toString(2),
                                    base3: (parseInt(numberValue, 13)).toString(3),
                                    base4: (parseInt(numberValue, 13)).toString(4),
                                    base5: (parseInt(numberValue, 13)).toString(5),
                                    base6: (parseInt(numberValue, 13)).toString(6),
                                    base7: (parseInt(numberValue, 13)).toString(7),
                                    base8: (parseInt(numberValue, 13)).toString(8),
                                    base9: (parseInt(numberValue, 13)).toString(9),
                                    base10: (parseInt(numberValue, 13)).toString(10),
                                    base11: (parseInt(numberValue, 13)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 13)).toString(12).toUpperCase(),
                                    base13: numberValue.toUpperCase(),
                                    base14: (parseInt(numberValue, 13)).toString(14).toUpperCase(),
                                };
                                break;
                            case "base14":
                                result = {
                                    decimal: parseInt(numberValue, 14),
                                    binary: (parseInt(numberValue, 14)).toString(2),
                                    octal: (parseInt(numberValue, 14)).toString(8),
                                    hexadecimal: (parseInt(numberValue, 14)).toString(16).toUpperCase(),
                                    base2: (parseInt(numberValue, 14)).toString(2),
                                    base3: (parseInt(numberValue, 14)).toString(3),
                                    base4: (parseInt(numberValue, 14)).toString(4),
                                    base5: (parseInt(numberValue, 14)).toString(5),
                                    base6: (parseInt(numberValue, 14)).toString(6),
                                    base7: (parseInt(numberValue, 14)).toString(7),
                                    base8: (parseInt(numberValue, 14)).toString(8),
                                    base9: (parseInt(numberValue, 14)).toString(9),
                                    base10: (parseInt(numberValue, 14)).toString(10),
                                    base11: (parseInt(numberValue, 14)).toString(11).toUpperCase(),
                                    base12: (parseInt(numberValue, 14)).toString(12).toUpperCase(),
                                    base13: (parseInt(numberValue, 14)).toString(13).toUpperCase(),
                                    base14: numberValue.toUpperCase(),
                                };
                                break;
                        }
                        // Display the result
                        document.getElementById("numbersResult").innerHTML =
                            "Binary: " + result.binary + "<br>" +
                            "Octal: " + result.octal + "<br>" +
                            "Decimal: " + formatResult(result.decimal, notation, decimalPlaces) + "<br>" +
                            "Hexadecimal: " + result.hexadecimal + "<br>" +
                            "Base-2: " + result.base2 + "<br>" +
                            "Base-3: " + result.base3 + "<br>" +
                            "Base-4: " + result.base4 + "<br>" +
                            "Base-5: " + result.base5 + "<br>" +
                            "Base-6: " + result.base6 + "<br>" +
                            "Base-7: " + result.base7 + "<br>" +
                            "Base-8: " + result.base8 + "<br>" +
                            "Base-9: " + result.base9 + "<br>" +
                            "Base-10: " + result.base10 + "<br>" +
                            "Base-11: " + result.base11 + "<br>" +
                            "Base-12: " + result.base12 + "<br>" +
                            "Base-13: " + result.base13 + "<br>" +
                            "Base-14: " + result.base14;

                        function validateInput(value, unit) {
                            switch (unit) {
                                case "binary":
                                    return /^[01]+$/.test(value);
                                case "octal":
                                    return /^[0-7]+$/.test(value);
                                case "decimal":
                                    return /^\d+$/.test(value);
                                case "hexadecimal":
                                    return /^[0-9A-F]+$/.test(value);
                                case "base2":
                                    return /^[01]+$/.test(value);
                                case "base3":
                                    return /^[0-2]+$/.test(value);
                                case "base4":
                                    return /^[0-3]+$/.test(value);
                                case "base5":
                                    return /^[0-4]+$/.test(value);
                                case "base6":
                                    return /^[0-5]+$/.test(value);
                                case "base7":
                                    return /^[0-6]+$/.test(value);
                                case "base8":
                                    return /^[0-7]+$/.test(value);
                                case "base9":
                                    return /^[0-8]+$/.test(value);
                                case "base10":
                                    return /^[0-9]+$/.test(value);
                                case "base11":
                                    return /^[0-9aA]+$/.test(value);
                                case "base12":
                                    return /^[0-9ABab]+$/.test(value);
                                case "base13":
                                    return /^[0-9A-Ca-c]+$/.test(value);
                                case "base14":
                                    return /^[0-9A-Da-d]+$/.test(value);
                                default:
                                    return true; // Allow any input if unit is not recognized
                            }
                        }

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                            }
                        }
                    }

                    function convertAngle() {
                        // Get user input
                        var angleValue = parseFloat(document.getElementById("angleValue").value);
                        var angleUnit = document.getElementById("angleUnit").value;
                        var notation = document.getElementById("angleNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("angleDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (angleUnit) {
                            case "degree":
                                result = {
                                    degree: angleValue,
                                    radian: angleValue * (Math.PI / 180),
                                    gradian: angleValue * 1.11111,
                                    revolution: angleValue / 360,
                                    minute: angleValue * 60,
                                    second: angleValue * 3600
                                };
                                break;
                            case "radian":
                                result = {
                                    degree: angleValue * (180 / Math.PI),
                                    radian: angleValue,
                                    gradian: angleValue * (200 / Math.PI),
                                    revolution: angleValue / (2 * Math.PI),
                                    minute: angleValue * (60 / Math.PI),
                                    second: angleValue * (3600 / Math.PI)
                                };
                                break;
                            case "gradian":
                                result = {
                                    degree: angleValue * 0.9,
                                    radian: angleValue * (Math.PI / 200),
                                    gradian: angleValue,
                                    revolution: angleValue / 400,
                                    minute: angleValue * 54,
                                    second: angleValue * 3240
                                };
                                break;
                            case "revolution":
                                result = {
                                    degree: angleValue * 360,
                                    radian: angleValue * (2 * Math.PI),
                                    gradian: angleValue * 400,
                                    revolution: angleValue,
                                    minute: angleValue * 21600,
                                    second: angleValue * 1296000
                                };
                                break;
                            case "minute":
                                result = {
                                    degree: angleValue / 60,
                                    radian: angleValue * (Math.PI / 10800),
                                    gradian: angleValue / 54,
                                    revolution: angleValue / 21600,
                                    minute: angleValue,
                                    second: angleValue * 60
                                };
                                break;
                            case "second":
                                result = {
                                    degree: angleValue / 3600,
                                    radian: angleValue * (Math.PI / 648000),
                                    gradian: angleValue / 3240,
                                    revolution: angleValue / 1296000,
                                    minute: angleValue / 60,
                                    second: angleValue
                                };
                                break;
                        }

                        // Display the result
                        document.getElementById("angleResult").innerHTML = "Result: " +
                            "Degree: " + formatResult(result.degree, notation, decimalPlaces) + " °<br>" +
                            "Radian: " + formatResult(result.radian, notation, decimalPlaces) + " rad<br>" +
                            "Gradian: " + formatResult(result.gradian, notation, decimalPlaces) + " grad<br>" +
                            "Revolution: " + formatResult(result.revolution, notation, decimalPlaces) + " rev<br>" +
                            "minute: " + formatResult(result.minute, notation, decimalPlaces) + " &#39;<br>" +
                            "second: " + formatResult(result.second, notation, decimalPlaces) + " &#39;&#39;";

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                            }
                        }
                    }

                    function convertForce() {
                        // Get user input
                        var forceValue = parseFloat(document.getElementById("forceValue").value);
                        var forceUnit = document.getElementById("forceUnit").value;
                        var notation = document.getElementById("forceNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("forceDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (forceUnit) {
                            case "newton":
                                result = {
                                    newton: forceValue,
                                    kilonewton: forceValue / 1000,
                                    millinewton: forceValue * 1000,
                                    microNewton: forceValue * 1e6,
                                    dyne: forceValue * 1e5,
                                    poundForce: forceValue * 0.224808943,
                                    ounceForce: forceValue * 3.59694309,
                                    gramForce: forceValue * 101.971621,
                                    kilogramForce: forceValue * 0.101971621,
                                    kilopoundForce: forceValue * 0.000224808943,
                                    tonForce: forceValue * 1.01971621e-4,
                                    joulePerMeter: forceValue,
                                    joulePerCentimeter: forceValue * 100,
                                    kipForce: forceValue * 2.24808943e-5
                                };
                                break;
                            case "kilonewton":
                                result = {
                                    newton: forceValue * 1000,
                                    kilonewton: forceValue,
                                    millinewton: forceValue * 1e6,
                                    microNewton: forceValue * 1e9,
                                    dyne: forceValue * 1e8,
                                    poundForce: forceValue * 224.808943,
                                    ounceForce: forceValue * 3596.94309,
                                    gramForce: forceValue * 101971.621,
                                    kilogramForce: forceValue * 101.971621,
                                    kilopoundForce: forceValue * 0.224808943,
                                    tonForce: forceValue * 0.101971621,
                                    joulePerMeter: forceValue * 1000,
                                    joulePerCentimeter: forceValue * 100000,
                                    kipForce: forceValue * 0.0224808943
                                };
                                break;
                            case "millinewton":
                                result = {
                                    newton: forceValue / 1000,
                                    kilonewton: forceValue * 1e-6,
                                    millinewton: forceValue,
                                    microNewton: forceValue * 1000,
                                    dyne: forceValue * 0.1,
                                    poundForce: forceValue * 2.24808943e-7,
                                    ounceForce: forceValue * 3.59694309e-6,
                                    gramForce: forceValue * 0.101971621,
                                    kilogramForce: forceValue * 1.01971621e-4,
                                    kilopoundForce: forceValue * 2.24808943e-10,
                                    tonForce: forceValue * 1.01971621e-7,
                                    joulePerMeter: forceValue * 0.001,
                                    joulePerCentimeter: forceValue * 0.1,
                                    kipForce: forceValue * 2.24808943e-13
                                };
                                break;
                            case "microNewton":
                                result = {
                                    newton: forceValue / 1e6,
                                    kilonewton: forceValue * 1e-9,
                                    millinewton: forceValue / 1000,
                                    microNewton: forceValue,
                                    dyne: forceValue * 0.0001,
                                    poundForce: forceValue * 2.24808943e-10,
                                    ounceForce: forceValue * 3.59694309e-9,
                                    gramForce: forceValue * 1.019971621e-7,
                                    kilogramForce: forceValue * 1.01971621e-10,
                                    kilopoundForce: forceValue * 2.24808943e-13,
                                    tonForce: forceValue * 1.01971621e-10,
                                    joulePerMeter: forceValue * 1e-6,
                                    joulePerCentimeter: forceValue * 0.0001,
                                    kipForce: forceValue * 2.24808943e-16
                                };
                                break;
                            case "dyne":
                                result = {
                                    newton: forceValue * 0.01,
                                    kilonewton: forceValue * 1e-8,
                                    millinewton: forceValue * 10,
                                    microNewton: forceValue * 10000,
                                    dyne: forceValue,
                                    poundForce: forceValue * 2.24808943e-6,
                                    ounceForce: forceValue * 3.59694309e-5,
                                    gramForce: forceValue * 0.00101971621,
                                    kilogramForce: forceValue * 1.01971621e-6,
                                    kilopoundForce: forceValue * 2.24808943e-9,
                                    tonForce: forceValue * 1.01971621e-6,
                                    joulePerMeter: forceValue * 0.1,
                                    joulePerCentimeter: forceValue * 10,
                                    kipForce: forceValue * 2.24808943e-10
                                };
                                break;
                            case "poundForce":
                                result = {
                                    newton: forceValue * 4.4482216,
                                    kilonewton: forceValue * 0.0044482216,
                                    millinewton: forceValue * 4448.2216,
                                    microNewton: forceValue * 4448221.6,
                                    dyne: forceValue * 444822.16,
                                    poundForce: forceValue,
                                    ounceForce: forceValue * 16,
                                    gramForce: forceValue * 453.59237,
                                    kilogramForce: forceValue * 0.45359237,
                                    kilopoundForce: forceValue * 0.001,
                                    tonForce: forceValue * 0.00045359237,
                                    joulePerMeter: forceValue * 4.4482216,
                                    joulePerCentimeter: forceValue * 444.82216,
                                    kipForce: forceValue * 0.000031081
                                };
                                break;
                            case "ounceForce":
                                result = {
                                    newton: forceValue * 0.27801385,
                                    kilonewton: forceValue * 0.00027801385,
                                    millinewton: forceValue * 278.01385,
                                    microNewton: forceValue * 278013.85,
                                    dyne: forceValue * 27801.385,
                                    poundForce: forceValue * 0.0625,
                                    ounceForce: forceValue,
                                    gramForce: forceValue * 28.3495231,
                                    kilogramForce: forceValue * 0.0283495231,
                                    kilopoundForce: forceValue * 6.25e-5,
                                    tonForce: forceValue * 2.835e-5,
                                    joulePerMeter: forceValue * 0.27801385,
                                    joulePerCentimeter: forceValue * 27.801385,
                                    kipForce: forceValue * 1.73672e-6
                                };
                                break;
                            case "gramForce":
                                result = {
                                    newton: forceValue * 0.00980665,
                                    kilonewton: forceValue * 9.80665e-6,
                                    millinewton: forceValue * 9.80665,
                                    microNewton: forceValue * 9806.65,
                                    dyne: forceValue * 980.665,
                                    poundForce: forceValue * 0.00220462262,
                                    ounceForce: forceValue * 0.03527396,
                                    gramForce: forceValue,
                                    kilogramForce: forceValue * 0.001,
                                    kilopoundForce: forceValue * 2.20462262e-6,
                                    tonForce: forceValue * 1.10231131e-6,
                                    joulePerMeter: forceValue * 0.00980665,
                                    joulePerCentimeter: forceValue * 0.980665,
                                    kipForce: forceValue * 6.248e-8
                                };
                                break;
                            case "kilogramForce":
                                result = {
                                    newton: forceValue * 9.80665,
                                    kilonewton: forceValue * 0.00980665,
                                    millinewton: forceValue * 9806.65,
                                    microNewton: forceValue * 9806650,
                                    dyne: forceValue * 980665,
                                    poundForce: forceValue * 2.20462262,
                                    ounceForce: forceValue * 35.27396,
                                    gramForce: forceValue * 1000,
                                    kilogramForce: forceValue,
                                    kilopoundForce: forceValue * 0.00220462262,
                                    tonForce: forceValue * 0.00110231131,
                                    joulePerMeter: forceValue * 9.80665,
                                    joulePerCentimeter: forceValue * 980.665,
                                    kipForce: forceValue * 6.248e-5
                                };
                                break;
                            case "kilopoundForce":
                                result = {
                                    newton: forceValue * 4448.2216,
                                    kilonewton: forceValue * 4.4482216,
                                    millinewton: forceValue * 4448221.6,
                                    microNewton: forceValue * 4448221600,
                                    dyne: forceValue * 444822160,
                                    poundForce: forceValue * 1000,
                                    ounceForce: forceValue * 16000,
                                    gramForce: forceValue * 453592.37,
                                    kilogramForce: forceValue * 453.59237,
                                    kilopoundForce: forceValue,
                                    tonForce: forceValue * 0.00045359237,
                                    joulePerMeter: forceValue * 4448.2216,
                                    joulePerCentimeter: forceValue * 444822.16,
                                    kipForce: forceValue * 0.031081
                                };
                                break;
                            case "tonForce":
                                result = {
                                    newton: forceValue * 9806.65,
                                    kilonewton: forceValue * 9.80665,
                                    millinewton: forceValue * 9806650,
                                    microNewton: forceValue * 9806650000,
                                    dyne: forceValue * 980665000,
                                    poundForce: forceValue * 2204.62262,
                                    ounceForce: forceValue * 35273.96,
                                    gramForce: forceValue * 1000000,
                                    kilogramForce: forceValue * 1000,
                                    kilopoundForce: forceValue * 0.00220462262,
                                    tonForce: forceValue,
                                    joulePerMeter: forceValue * 9806.65,
                                    joulePerCentimeter: forceValue * 980665,
                                    kipForce: forceValue * 0.6248
                                };
                                break;
                            case "joulePerMeter":
                                result = {
                                    newton: forceValue,
                                    kilonewton: forceValue * 0.001,
                                    millinewton: forceValue * 1000,
                                    microNewton: forceValue * 1000000,
                                    dyne: forceValue * 100000,
                                    poundForce: forceValue * 0.224808943,
                                    ounceForce: forceValue * 3.59694309,
                                    gramForce: forceValue * 101.971621,
                                    kilogramForce: forceValue * 0.101971621,
                                    kilopoundForce: forceValue * 0.000224808943,
                                    tonForce: forceValue * 1.01971621e-4,
                                    joulePerMeter: forceValue,
                                    joulePerCentimeter: forceValue * 100,
                                    kipForce: forceValue * 0.0224808943
                                };
                                break;
                            case "joulePerCentimeter":
                                result = {
                                    newton: forceValue * 0.01,
                                    kilonewton: forceValue * 1e-5,
                                    millinewton: forceValue * 10,
                                    microNewton: forceValue * 10000,
                                    dyne: forceValue * 1000,
                                    poundForce: forceValue * 0.00224808943,
                                    ounceForce: forceValue * 0.0359694309,
                                    gramForce: forceValue * 1.01971621,
                                    kilogramForce: forceValue * 0.00101971621,
                                    kilopoundForce: forceValue * 2.24808943e-6,
                                    tonForce: forceValue * 1.01971621e-3,
                                    joulePerMeter: forceValue * 0.01,
                                    joulePerCentimeter: forceValue,
                                    kipForce: forceValue * 2.24808943e-5
                                };
                                break;
                            case "kipForce":
                                result = {
                                    newton: forceValue * 4448.2216,
                                    kilonewton: forceValue * 4.4482216,
                                    millinewton: forceValue * 4448221.6,
                                    microNewton: forceValue * 4448221600,
                                    dyne: forceValue * 444822160,
                                    poundForce: forceValue * 1000,
                                    ounceForce: forceValue * 16000,
                                    gramForce: forceValue * 453592.37,
                                    kilogramForce: forceValue * 453.59237,
                                    kilopoundForce: forceValue,
                                    tonForce: forceValue * 0.00045359237,
                                    joulePerMeter: forceValue * 4448.2216,
                                    joulePerCentimeter: forceValue * 444822.16,
                                    kipForce: forceValue
                                };
                                break;
                        }

                        // Display the result
                        document.getElementById("forceResult").innerHTML = "Result: " +
                            "Newton: " + formatResult(result.newton, notation, decimalPlaces) + " N<br>" +
                            "Kilonewton: " + formatResult(result.kilonewton, notation, decimalPlaces) + " kN<br>" +
                            "Millinewton: " + formatResult(result.millinewton, notation, decimalPlaces) + " mN<br>" +
                            "MicroNewton: " + formatResult(result.microNewton, notation, decimalPlaces) + " µN<br>" +
                            "Dyne: " + formatResult(result.dyne, notation, decimalPlaces) + " dyn<br>" +
                            "Pound-force: " + formatResult(result.poundForce, notation, decimalPlaces) + " lbf<br>" +
                            "Ounce-force: " + formatResult(result.ounceForce, notation, decimalPlaces) + " ozf<br>" +
                            "Gram-force: " + formatResult(result.gramForce, notation, decimalPlaces) + " gf<br>" +
                            "Kilogram-force: " + formatResult(result.kilogramForce, notation, decimalPlaces) + " kgf<br>" +
                            "Kilopound-force: " + formatResult(result.kilopoundForce, notation, decimalPlaces) + " kip<br>" +
                            "Ton-force: " + formatResult(result.tonForce, notation, decimalPlaces) + " ton<br>" +
                            "Joule/meter: " + formatResult(result.joulePerMeter, notation, decimalPlaces) + " J/m<br>" +
                            "Joule/centimeter: " + formatResult(result.joulePerCentimeter, notation, decimalPlaces) + " J/cm<br>" +
                            "Kip-force: " + formatResult(result.kipForce, notation, decimalPlaces) + " kipf<br>";

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                            }
                        }
                    }



                    function convertPower() {
                        // Get user input
                        var powerValue = parseFloat(document.getElementById("powerValue").value);
                        var powerUnit = document.getElementById("powerUnit").value;
                        var notation = document.getElementById("powerNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("powerDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (powerUnit) {
                            case "watt":
                                result = {
                                    watt: powerValue,
                                    kilowatt: powerValue / 1000,
                                    megawatt: powerValue / 1e6,
                                    gigawatt: powerValue / 1e9,
                                    horsepower: powerValue / 745.7,
                                    metricHorsepower: powerValue / 735.5,
                                    electricalHorsepower: powerValue / 746,
                                    boilerHorsepower: powerValue / 9.8107,
                                    footPoundPerSecond: powerValue * 1.3558,
                                    footPoundPerMinute: powerValue * 81.349,
                                    footPoundPerHour: powerValue * 4889.9,
                                    caloriePerSecond: powerValue * 0.23885,
                                    caloriePerMinute: powerValue * 14.331,
                                    caloriePerHour: powerValue * 859.85,
                                    voltAmpere: powerValue,
                                    kilovoltAmpere: powerValue / 1000,
                                };
                                break;
                            case "kilowatt":
                                result = {
                                    watt: powerValue * 1000,
                                    kilowatt: powerValue,
                                    megawatt: powerValue / 1e3,
                                    gigawatt: powerValue / 1e6,
                                    horsepower: powerValue / 0.7457,
                                    metricHorsepower: powerValue / 0.7355,
                                    electricalHorsepower: powerValue / 0.746,
                                    boilerHorsepower: powerValue / 0.0098107,
                                    footPoundPerSecond: powerValue * 1355.8,
                                    footPoundPerMinute: powerValue * 81347,
                                    footPoundPerHour: powerValue * 4889900,
                                    caloriePerSecond: powerValue * 238.85,
                                    caloriePerMinute: powerValue * 14331,
                                    caloriePerHour: powerValue * 859850,
                                    voltAmpere: powerValue * 1000,
                                    kilovoltAmpere: powerValue,
                                };
                                break;
                            case "megawatt":
                                result = {
                                    watt: powerValue * 1e6,
                                    kilowatt: powerValue * 1e3,
                                    megawatt: powerValue,
                                    gigawatt: powerValue / 1e3,
                                    horsepower: powerValue / 0.0007457,
                                    metricHorsepower: powerValue / 0.0007355,
                                    electricalHorsepower: powerValue / 0.000746,
                                    boilerHorsepower: powerValue / 0.0000098107,
                                    footPoundPerSecond: powerValue * 1355800,
                                    footPoundPerMinute: powerValue * 81347000,
                                    footPoundPerHour: powerValue * 4889800000,
                                    caloriePerSecond: powerValue * 238850,
                                    caloriePerMinute: powerValue * 14331000,
                                    caloriePerHour: powerValue * 859850000,
                                    voltAmpere: powerValue * 1e6,
                                    kilovoltAmpere: powerValue * 1e3,
                                };
                                break;
                            case "gigawatt":
                                result = {
                                    watt: powerValue * 1e9,
                                    kilowatt: powerValue * 1e6,
                                    megawatt: powerValue * 1e3,
                                    gigawatt: powerValue,
                                    horsepower: powerValue / 7.457e-7,
                                    metricHorsepower: powerValue / 7.355e-7,
                                    electricalHorsepower: powerValue / 7.46e-7,
                                    boilerHorsepower: powerValue / 9.8107e-9,
                                    footPoundPerSecond: powerValue * 1.3558e9,
                                    footPoundPerMinute: powerValue * 8.1347e10,
                                    footPoundPerHour: powerValue * 4.8898e12,
                                    caloriePerSecond: powerValue * 2.3885e8,
                                    caloriePerMinute: powerValue * 1.4331e10,
                                    caloriePerHour: powerValue * 8.5985e11,
                                    voltAmpere: powerValue * 1e9,
                                    kilovoltAmpere: powerValue * 1e6,
                                };
                                break;
                            case "horsepower":
                                result = {
                                    watt: powerValue * 745.7,
                                    kilowatt: powerValue * 0.7457,
                                    megawatt: powerValue * 7.457e-4,
                                    gigawatt: powerValue * 7.457e-7,
                                    horsepower: powerValue,
                                    metricHorsepower: powerValue / 1.014,
                                    electricalHorsepower: powerValue / 1.0139,
                                    boilerHorsepower: powerValue / 0.0098107,
                                    footPoundPerSecond: powerValue * 550,
                                    footPoundPerMinute: powerValue * 33000,
                                    footPoundPerHour: powerValue * 1980000,
                                    caloriePerSecond: powerValue * 42.4,
                                    caloriePerMinute: powerValue * 2544,
                                    caloriePerHour: powerValue * 152640,
                                    voltAmpere: powerValue * 745.7,
                                    kilovoltAmpere: powerValue * 0.7457,
                                };
                                break;
                            case "metricHorsepower":
                                result = {
                                    watt: powerValue * 735.5,
                                    kilowatt: powerValue * 0.7355,
                                    megawatt: powerValue * 7.355e-4,
                                    gigawatt: powerValue * 7.355e-7,
                                    horsepower: powerValue * 1.014,
                                    metricHorsepower: powerValue,
                                    electricalHorsepower: powerValue / 1.0139,
                                    boilerHorsepower: powerValue / 0.0098107,
                                    footPoundPerSecond: powerValue * 542.5,
                                    footPoundPerMinute: powerValue * 32550,
                                    footPoundPerHour: powerValue * 1953000,
                                    caloriePerSecond: powerValue * 42.2,
                                    caloriePerMinute: powerValue * 2532,
                                    caloriePerHour: powerValue * 151920,
                                    voltAmpere: powerValue * 735.5,
                                    kilovoltAmpere: powerValue * 0.7355,
                                };
                                break;
                            case "electricalHorsepower":
                                result = {
                                    watt: powerValue * 746,
                                    kilowatt: powerValue * 0.746,
                                    megawatt: powerValue * 7.46e-4,
                                    gigawatt: powerValue * 7.46e-7,
                                    horsepower: powerValue * 1.0139,
                                    metricHorsepower: powerValue * 1.0139,
                                    electricalHorsepower: powerValue,
                                    boilerHorsepower: powerValue / 0.0098107,
                                    footPoundPerSecond: powerValue * 550.56,
                                    footPoundPerMinute: powerValue * 33033,
                                    footPoundPerHour: powerValue * 1981980,
                                    caloriePerSecond: powerValue * 42.42,
                                    caloriePerMinute: powerValue * 2545,
                                    caloriePerHour: powerValue * 152700,
                                    voltAmpere: powerValue * 746,
                                    kilovoltAmpere: powerValue * 0.746,
                                };
                                break;
                            case "boilerHorsepower":
                                result = {
                                    watt: powerValue * 9.8107,
                                    kilowatt: powerValue * 0.0098107,
                                    megawatt: powerValue * 9.8107e-6,
                                    gigawatt: powerValue * 9.8107e-9,
                                    horsepower: powerValue * 0.0098107,
                                    metricHorsepower: powerValue * 0.0098107,
                                    electricalHorsepower: powerValue * 0.0098107,
                                    boilerHorsepower: powerValue,
                                    footPoundPerSecond: powerValue * 550,
                                    footPoundPerMinute: powerValue * 33000,
                                    footPoundPerHour: powerValue * 1980000,
                                    caloriePerSecond: powerValue * 42.4,
                                    caloriePerMinute: powerValue * 2544,
                                    caloriePerHour: powerValue * 152640,
                                    voltAmpere: powerValue * 9.8107,
                                    kilovoltAmpere: powerValue * 0.0098107,
                                };
                                break;
                            case "footPoundPerSecond":
                                result = {
                                    watt: powerValue / 1.3558,
                                    kilowatt: powerValue / 1355.8,
                                    megawatt: powerValue / 1.3558e6,
                                    gigawatt: powerValue / 1.3558e9,
                                    horsepower: powerValue / 550,
                                    metricHorsepower: powerValue / 542.5,
                                    electricalHorsepower: powerValue / 550.56,
                                    boilerHorsepower: powerValue / 9.8107,
                                    footPoundPerSecond: powerValue,
                                    footPoundPerMinute: powerValue * 60,
                                    footPoundPerHour: powerValue * 3600,
                                    caloriePerSecond: powerValue / 42.4,
                                    caloriePerMinute: powerValue * 0.01667,
                                    caloriePerHour: powerValue * 0.001,
                                    voltAmpere: powerValue / 0.73756,
                                    kilovoltAmpere: powerValue / 737.56,
                                };
                                break;
                            case "footPoundPerMinute":
                                result = {
                                    watt: powerValue / 81.349,
                                    kilowatt: powerValue / 81347,
                                    megawatt: powerValue / 8.1347e7,
                                    gigawatt: powerValue / 8.1347e10,
                                    horsepower: powerValue / 33000,
                                    metricHorsepower: powerValue / 32550,
                                    electricalHorsepower: powerValue / 33033,
                                    boilerHorsepower: powerValue / 5.515e5,
                                    footPoundPerSecond: powerValue / 60,
                                    footPoundPerMinute: powerValue,
                                    footPoundPerHour: powerValue * 60,
                                    caloriePerSecond: powerValue / 2544,
                                    caloriePerMinute: powerValue / 0.01667,
                                    caloriePerHour: powerValue * 0.001,
                                    voltAmpere: powerValue / 0.012292,
                                    kilovoltAmpere: powerValue / 12.292,
                                };
                                break;
                            case "footPoundPerHour":
                                result = {
                                    footPoundPerHour: powerValue,
                                    watt: powerValue / 2.65522e-7,
                                    kilowatt: powerValue / 2.65522e-10,
                                    megawatt: powerValue / 2.65522e-13,
                                    gigawatt: powerValue / 2.65522e-16,
                                    horsepower: powerValue / 198000.066,
                                    metricHorsepower: powerValue / 200000.01,
                                    electricalHorsepower: powerValue / 198439.943,
                                    boilerHorsepower: powerValue / 2.43354e-6,
                                    footPoundPerSecond: powerValue / 3600,
                                    footPoundPerMinute: powerValue / 60,
                                    caloriePerSecond: powerValue / 86042.027,
                                    caloriePerMinute: powerValue / 5162521.63,
                                    caloriePerHour: powerValue / 309751297.8,
                                    voltAmpere: powerValue / 3266180.54,
                                    kilovoltAmpere: powerValue / 3266.18054
                                };
                                break;
                            case "caloriePerSecond":
                                result = {
                                    watt: powerValue / 0.23885,
                                    kilowatt: powerValue / 238.85,
                                    megawatt: powerValue / 238850,
                                    gigawatt: powerValue / 238850000,
                                    horsepower: powerValue / 42.4,
                                    metricHorsepower: powerValue / 42.2,
                                    electricalHorsepower: powerValue / 42.42,
                                    boilerHorsepower: powerValue / 42.4,
                                    footPoundPerSecond: powerValue * 42.4,
                                    footPoundPerMinute: powerValue * 2544,
                                    footPoundPerHour: powerValue * 152640,
                                    caloriePerSecond: powerValue,
                                    caloriePerMinute: powerValue * 60,
                                    caloriePerHour: powerValue * 3600,
                                    voltAmpere: powerValue / 0.012292,
                                    kilovoltAmpere: powerValue / 12.292,
                                };
                                break;
                            case "caloriePerMinute":
                                result = {
                                    watt: powerValue / 14.331,
                                    kilowatt: powerValue / 14331,
                                    megawatt: powerValue / 14331000,
                                    gigawatt: powerValue / 14331000000,
                                    horsepower: powerValue / 2544,
                                    metricHorsepower: powerValue / 2532,
                                    electricalHorsepower: powerValue / 2545,
                                    boilerHorsepower: powerValue / 2544,
                                    footPoundPerSecond: powerValue * 2544,
                                    footPoundPerMinute: powerValue / 0.01667,
                                    footPoundPerHour: powerValue * 60,
                                    caloriePerSecond: powerValue / 60,
                                    caloriePerMinute: powerValue,
                                    caloriePerHour: powerValue * 60,
                                    voltAmpere: powerValue / 0.012292,
                                    kilovoltAmpere: powerValue / 12.292,
                                };
                                break;
                            case "caloriePerHour":
                                result = {
                                    watt: powerValue / 859.85,
                                    kilowatt: powerValue / 859850,
                                    megawatt: powerValue / 859850000,
                                    gigawatt: powerValue / 859850000000,
                                    horsepower: powerValue / 152640,
                                    metricHorsepower: powerValue / 151920,
                                    electricalHorsepower: powerValue / 152700,
                                    boilerHorsepower: powerValue / 152640,
                                    footPoundPerSecond: powerValue * 152640,
                                    footPoundPerMinute: powerValue / 0.001,
                                    footPoundPerHour: powerValue / 60,
                                    caloriePerSecond: powerValue / 3600,
                                    caloriePerMinute: powerValue / 60,
                                    caloriePerHour: powerValue,
                                    voltAmpere: powerValue / 0.012292,
                                    kilovoltAmpere: powerValue / 12.292,
                                };
                                break;

                            case "voltAmpere":
                                result = {
                                    watt: powerValue,
                                    kilowatt: powerValue / 1000,
                                    megawatt: powerValue / 1000000,
                                    gigawatt: powerValue / 1000000000,
                                    horsepower: powerValue / 745.7,
                                    metricHorsepower: powerValue / 735.5,
                                    electricalHorsepower: powerValue / 746,
                                    boilerHorsepower: powerValue / 9809.5,
                                    footPoundPerSecond: powerValue * 1.3558179483314,
                                    footPoundPerMinute: powerValue * 81.349076900,
                                    footPoundPerHour: powerValue * 4889.344614,
                                    caloriePerSecond: powerValue / 238.84589663,
                                    caloriePerMinute: powerValue / 14.330753798,
                                    caloriePerHour: powerValue / 0.85984522786,
                                    voltAmpere: powerValue,
                                    kilovoltAmpere: powerValue / 1000,
                                };
                                break;

                            case "kilovoltAmpere":
                                result = {
                                    watt: powerValue * 1000,
                                    kilowatt: powerValue,
                                    megawatt: powerValue / 1000,
                                    gigawatt: powerValue / 1000000,
                                    horsepower: powerValue * 1.341022089595,
                                    metricHorsepower: powerValue * 1.3596216173039,
                                    electricalHorsepower: powerValue * 1.3404825737265,
                                    boilerHorsepower: powerValue * 0.10194199504039,
                                    footPoundPerSecond: powerValue * 1355.8179483314,
                                    footPoundPerMinute: powerValue * 81234.9076900,
                                    footPoundPerHour: powerValue * 4874094.614,
                                    caloriePerSecond: powerValue * 0.23884589663,
                                    caloriePerMinute: powerValue * 14.330753798,
                                    caloriePerHour: powerValue * 859.84522786,
                                    voltAmpere: powerValue * 1000,
                                    kilovoltAmpere: powerValue,
                                };
                                break;

                        }

                        // Display the result
                        document.getElementById("powerResult").innerHTML = "Result: " +
                            "Watt: " + formatResult(result.watt, notation, decimalPlaces) + " W<br>" +
                            "Kilowatt: " + formatResult(result.kilowatt, notation, decimalPlaces) + " kW<br>" +
                            "Megawatt: " + formatResult(result.megawatt, notation, decimalPlaces) + " MW<br>" +
                            "Gigawatt: " + formatResult(result.gigawatt, notation, decimalPlaces) + " GW<br>" +
                            "Horsepower: " + formatResult(result.horsepower, notation, decimalPlaces) + " hp<br>" +
                            "Metric Horsepower: " + formatResult(result.metricHorsepower, notation, decimalPlaces) + "<br>" +
                            "Electrical Horsepower: " + formatResult(result.electricalHorsepower, notation, decimalPlaces) + "<br>" +
                            "Boiler Horsepower: " + formatResult(result.boilerHorsepower, notation, decimalPlaces) + "<br>" +
                            "Foot-Pound/Second: " + formatResult(result.footPoundPerSecond, notation, decimalPlaces) + "<br>" +
                            "Foot-Pound/Minute: " + formatResult(result.footPoundPerMinute, notation, decimalPlaces) + "<br>" +
                            "Foot-Pound/Hour: " + formatResult(result.footPoundPerHour, notation, decimalPlaces) + "<br>" +
                            "Calorie/Second: " + formatResult(result.caloriePerSecond, notation, decimalPlaces) + " cal/s<br>" +
                            "Calorie/Minute: " + formatResult(result.caloriePerMinute, notation, decimalPlaces) + " cal/min<br>" +
                            "Calorie/Hour: " + formatResult(result.caloriePerHour, notation, decimalPlaces) + " cal/h<br>" +
                            "Volt Ampere: " + formatResult(result.voltAmpere, notation, decimalPlaces) + " VA<br>" +
                            "Kilovolt Ampere: " + formatResult(result.kilovoltAmpere, notation, decimalPlaces) + " kVA<br>"

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                    break;
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                    break;
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                                    break;
                            }
                        }
                    }

                    function convertEnergy() {
                        // Get user input
                        var energyValue = parseFloat(document.getElementById("energyValue").value);
                        var energyUnit = document.getElementById("energyUnit").value;
                        var notation = document.getElementById("energyNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("energyDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (energyUnit) {
                            case "joule":
                                result = {
                                    joule: energyValue,
                                    kilojoule: energyValue * 0.001,
                                    kilowattHour: energyValue * 2.77778e-7,
                                    wattHour: energyValue * 0.000277778,
                                    calorie: energyValue * 0.239006,
                                    kilocalorie: energyValue * 0.000239006,
                                    electronVolt: energyValue * 6.242e+18,
                                    kielectronVolt: energyValue * 6.242e+15,
                                    hartreeEnergy: energyValue * 2.29371e+17,
                                    rydbergConstant: energyValue * 4.58742e+15
                                };
                                break;
                            case "kilojoule":
                                result = {
                                    kilojoule: energyValue,
                                    joule: energyValue * 1000,
                                    kilowattHour: energyValue * 2.77778e-4,
                                    wattHour: energyValue * 0.277778,
                                    calorie: energyValue * 239.006,
                                    kilocalorie: energyValue * 0.239006,
                                    electronVolt: energyValue * 6.242e+21,
                                    kielectronVolt: energyValue * 6.242e+18,
                                    hartreeEnergy: energyValue * 2.29371e+20,
                                    rydbergConstant: energyValue * 4.58742e+18
                                };
                                break;
                            case "kilowattHour":
                                result = {
                                    kilowattHour: energyValue,
                                    joule: energyValue * 3.6e+6,
                                    kilojoule: energyValue * 3600,
                                    wattHour: energyValue * 1000,
                                    calorie: energyValue * 860420,
                                    kilocalorie: energyValue * 860.42,
                                    electronVolt: energyValue * 2.24694e+22,
                                    kielectronVolt: energyValue * 2.24694e+19,
                                    hartreeEnergy: energyValue * 8.18711e+20,
                                    rydbergConstant: energyValue * 1.63742e+19
                                };
                                break;
                            case "wattHour":
                                result = {
                                    wattHour: energyValue,
                                    joule: energyValue * 3600,
                                    kilojoule: energyValue * 3.6,
                                    kilowattHour: energyValue * 0.001,
                                    calorie: energyValue * 860.42,
                                    kilocalorie: energyValue * 0.86042,
                                    electronVolt: energyValue * 2.24694e+19,
                                    kielectronVolt: energyValue * 2.24694e+16,
                                    hartreeEnergy: energyValue * 8.18711e+17,
                                    rydbergConstant: energyValue * 1.63742e+16
                                };
                                break;
                            case "calorie":
                                result = {
                                    calorie: energyValue,
                                    joule: energyValue * 4.184,
                                    kilojoule: energyValue * 0.004184,
                                    kilowattHour: energyValue * 1.1628e-6,
                                    wattHour: energyValue * 0.0011628,
                                    kilocalorie: energyValue * 0.001,
                                    electronVolt: energyValue * 2.611e+19,
                                    kielectronVolt: energyValue * 2.611e+16,
                                    hartreeEnergy: energyValue * 9.47817e+17,
                                    rydbergConstant: energyValue * 1.89574e+16
                                };
                                break;
                            case "kilocalorie":
                                result = {
                                    kilocalorie: energyValue,
                                    joule: energyValue * 4184,
                                    kilojoule: energyValue * 4.184,
                                    kilowattHour: energyValue * 1.1628e-3,
                                    wattHour: energyValue * 1.1628,
                                    calorie: energyValue * 1000,
                                    electronVolt: energyValue * 2.611e+22,
                                    kielectronVolt: energyValue * 2.611e+19,
                                    hartreeEnergy: energyValue * 9.47817e+20,
                                    rydbergConstant: energyValue * 1.89574e+19
                                };
                                break;
                            case "electronVolt":
                                result = {
                                    electronVolt: energyValue,
                                    joule: energyValue * 1.60218e-19,
                                    kilojoule: energyValue * 1.60218e-22,
                                    kilowattHour: energyValue * 4.4505e-26,
                                    wattHour: energyValue * 4.4505e-23,
                                    calorie: energyValue * 3.8293e-20,
                                    kilocalorie: energyValue * 3.8293e-23,
                                    kielectronVolt: energyValue * 1e-6,
                                    hartreeEnergy: energyValue * 3.67493e-18,
                                    rydbergConstant: energyValue * 7.34985e-20
                                };
                                break;
                            case "kielectronVolt":
                                result = {
                                    kielectronVolt: energyValue,
                                    joule: energyValue * 1.60218e-16,
                                    kilojoule: energyValue * 1.60218e-19,
                                    kilowattHour: energyValue * 4.4505e-23,
                                    wattHour: energyValue * 4.4505e-20,
                                    calorie: energyValue * 3.8293e-17,
                                    kilocalorie: energyValue * 3.8293e-20,
                                    electronVolt: energyValue * 1e+6,
                                    hartreeEnergy: energyValue * 3.67493e-14,
                                    rydbergConstant: energyValue * 7.34985e-16
                                };
                                break;
                            case "hartreeEnergy":
                                result = {
                                    hartreeEnergy: energyValue,
                                    joule: energyValue * 4.35974e-18,
                                    kilojoule: energyValue * 4.35974e-21,
                                    kilowattHour: energyValue * 1.21e-24,
                                    wattHour: energyValue * 1.21e-21,
                                    calorie: energyValue * 1.044e-18,
                                    kilocalorie: energyValue * 1.044e-21,
                                    electronVolt: energyValue * 2.72114e+18,
                                    kielectronVolt: energyValue * 2.72114e+15,
                                    rydbergConstant: energyValue * 2.03987e-17
                                };
                                break;
                            case "rydbergConstant":
                                result = {
                                    rydbergConstant: energyValue,
                                    joule: energyValue * 2.17987e-18,
                                    kilojoule: energyValue * 2.17987e-21,
                                    kilowattHour: energyValue * 6.05e-25,
                                    wattHour: energyValue * 6.05e-22,
                                    calorie: energyValue * 5.214e-19,
                                    kilocalorie: energyValue * 5.214e-22,
                                    electronVolt: energyValue * 1.09737e+17,
                                    kielectronVolt: energyValue * 1.09737e+14,
                                    hartreeEnergy: energyValue * 4.899e-18
                                };
                                break;
                        }

                        // Display the result
                        document.getElementById("energyResult").innerHTML = "Result: " +
                            "Joule: " + formatResult(result.joule, notation, decimalPlaces) + " J<br>" +
                            "Kilojoule: " + formatResult(result.kilojoule, notation, decimalPlaces) + " kJ<br>" +
                            "Kilowatt-hour: " + formatResult(result.kilowattHour, notation, decimalPlaces) + " kWh<br>" +
                            "Watt-hour: " + formatResult(result.wattHour, notation, decimalPlaces) + " Wh<br>" +
                            "Calorie: " + formatResult(result.calorie, notation, decimalPlaces) + " cal<br>" +
                            "Kilocalorie: " + formatResult(result.kilocalorie, notation, decimalPlaces) + " kcal<br>" +
                            "Electron-volt: " + formatResult(result.electronVolt, notation, decimalPlaces) + " eV<br>" +
                            "Kiloelectron-volt: " + formatResult(result.kielectronVolt, notation, decimalPlaces) + " keV<br>" +
                            "Hartree Energy: " + formatResult(result.hartreeEnergy, notation, decimalPlaces) + " <br>" +
                            "Rydberg Constant: " + formatResult(result.rydbergConstant, notation, decimalPlaces) + " <br>";

                        // Function to format the result
                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                    break;
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                    break;
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                                    break;
                            }
                        }
                    }


                    function convertPressure() {
                        // Get user input
                        var pressureValue = parseFloat(document.getElementById("pressureValue").value);
                        var pressureUnit = document.getElementById("pressureUnit").value;
                        var notation = document.getElementById("pressureNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("pressureDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (pressureUnit) {
                            case "pascal":
                                result = {
                                    pascal: pressureValue,
                                    kilopascal: pressureValue * 0.001,
                                    megapascal: pressureValue * 1e-6,
                                    gigapascal: pressureValue * 1e-9,
                                    atmosphere: pressureValue * 9.86923e-6,
                                    bar: pressureValue * 1e-5,
                                    millibar: pressureValue * 0.01,
                                    microbar: pressureValue * 100,
                                    millimeterOfMercury: pressureValue * 0.00750062,
                                    inchOfMercury: pressureValue * 0.0002953,
                                    poundPerSquareInch: pressureValue * 0.00014503773773359,
                                    ksi: pressureValue * 1.4503773773357e-7,
                                    torr: pressureValue * 0.00750062,
                                    centimeterOfWater: pressureValue * 0.101971621,
                                    millimeterOfWater: pressureValue * 10197.1621,
                                    kilogramPerSquareMeter: pressureValue,
                                    kilogramPerSquareCentimeter: pressureValue * 1e-4,
                                    kilogramPerSquareMillimeter: pressureValue * 1e-6
                                };
                                break;
                            case "kilopascal":
                                result = {
                                    pascal: pressureValue * 1000,
                                    kilopascal: pressureValue,
                                    megapascal: pressureValue * 1e-3,
                                    gigapascal: pressureValue * 1e-6,
                                    atmosphere: pressureValue * 9.86923e-3,
                                    bar: pressureValue * 1e-2,
                                    millibar: pressureValue * 10,
                                    microbar: pressureValue * 1e4,
                                    millimeterOfMercury: pressureValue * 7.50062,
                                    inchOfMercury: pressureValue * 0.2953,
                                    poundPerSquareInch: pressureValue * 0.14503773773359,
                                    ksi: pressureValue * 1.4503773773357e-4,
                                    torr: pressureValue * 7.50062,
                                    centimeterOfWater: pressureValue * 10.1971621,
                                    millimeterOfWater: pressureValue * 101971.621,
                                    kilogramPerSquareMeter: pressureValue * 1000,
                                    kilogramPerSquareCentimeter: pressureValue,
                                    kilogramPerSquareMillimeter: pressureValue * 1e-3
                                };
                                break;
                            case "megapascal":
                                result = {
                                    pascal: pressureValue * 1e6,
                                    kilopascal: pressureValue * 1000,
                                    megapascal: pressureValue,
                                    gigapascal: pressureValue * 1e-3,
                                    atmosphere: pressureValue * 9.86923e-3,
                                    bar: pressureValue * 1e-2,
                                    millibar: pressureValue * 10,
                                    microbar: pressureValue * 1e4,
                                    millimeterOfMercury: pressureValue * 7.50062,
                                    inchOfMercury: pressureValue * 0.2953,
                                    poundPerSquareInch: pressureValue * 0.14503773773359,
                                    ksi: pressureValue * 1.4503773773357e-4,
                                    torr: pressureValue * 7.50062,
                                    centimeterOfWater: pressureValue * 10.1971621,
                                    millimeterOfWater: pressureValue * 101971.621,
                                    kilogramPerSquareMeter: pressureValue * 1e6,
                                    kilogramPerSquareCentimeter: pressureValue * 1e4,
                                    kilogramPerSquareMillimeter: pressureValue
                                };
                                break;
                            case "gigapascal":
                                result = {
                                    pascal: pressureValue * 1e9,
                                    kilopascal: pressureValue * 1e6,
                                    megapascal: pressureValue * 1000,
                                    gigapascal: pressureValue,
                                    atmosphere: pressureValue * 9.86923e-6,
                                    bar: pressureValue * 1e-5,
                                    millibar: pressureValue * 0.01,
                                    microbar: pressureValue * 100,
                                    millimeterOfMercury: pressureValue * 0.00750062,
                                    inchOfMercury: pressureValue * 0.0002953,
                                    poundPerSquareInch: pressureValue * 0.00014503773773359,
                                    ksi: pressureValue * 1.4503773773357e-7,
                                    torr: pressureValue * 0.00750062,
                                    centimeterOfWater: pressureValue * 0.101971621,
                                    millimeterOfWater: pressureValue * 10197.1621,
                                    kilogramPerSquareMeter: pressureValue * 1e9,
                                    kilogramPerSquareCentimeter: pressureValue * 1e7,
                                    kilogramPerSquareMillimeter: pressureValue * 1e6
                                };
                                break;
                            case "atmosphere":
                                result = {
                                    pascal: pressureValue * 101325,
                                    kilopascal: pressureValue * 101.325,
                                    megapascal: pressureValue * 0.101325,
                                    gigapascal: pressureValue * 1.01325e-4,
                                    atmosphere: pressureValue,
                                    bar: pressureValue * 1.01325,
                                    millibar: pressureValue * 1013.25,
                                    microbar: pressureValue * 1.01325e6,
                                    millimeterOfMercury: pressureValue * 760,
                                    inchOfMercury: pressureValue * 29.9212,
                                    poundPerSquareInch: pressureValue * 14.696,
                                    ksi: pressureValue * 1.4223343312735e-3,
                                    torr: pressureValue * 760,
                                    centimeterOfWater: pressureValue * 1033.23,
                                    millimeterOfWater: pressureValue * 103322.3,
                                    kilogramPerSquareMeter: pressureValue * 101325,
                                    kilogramPerSquareCentimeter: pressureValue * 1.01325,
                                    kilogramPerSquareMillimeter: pressureValue * 1.01325e-3
                                };
                                break;
                            case "bar":
                                result = {
                                    pascal: pressureValue * 1e5,
                                    kilopascal: pressureValue * 100,
                                    megapascal: pressureValue * 0.1,
                                    gigapascal: pressureValue * 1e-7,
                                    atmosphere: pressureValue * 0.986923,
                                    bar: pressureValue,
                                    millibar: pressureValue * 1000,
                                    microbar: pressureValue * 1e6,
                                    millimeterOfMercury: pressureValue * 750.062,
                                    inchOfMercury: pressureValue * 29.5301,
                                    poundPerSquareInch: pressureValue * 14.5038,
                                    ksi: pressureValue * 1.4503773773357e-5,
                                    torr: pressureValue * 750.062,
                                    centimeterOfWater: pressureValue * 1019.72,
                                    millimeterOfWater: pressureValue * 101972,
                                    kilogramPerSquareMeter: pressureValue * 1e5,
                                    kilogramPerSquareCentimeter: pressureValue * 1e3,
                                    kilogramPerSquareMillimeter: pressureValue * 0.1
                                };
                                break;
                            case "millibar":
                                result = {
                                    pascal: pressureValue * 100,
                                    kilopascal: pressureValue * 0.1,
                                    megapascal: pressureValue * 1e-4,
                                    gigapascal: pressureValue * 1e-7,
                                    atmosphere: pressureValue * 0.000986923,
                                    bar: pressureValue * 0.001,
                                    millibar: pressureValue,
                                    microbar: pressureValue * 1000,
                                    millimeterOfMercury: pressureValue * 0.750062,
                                    inchOfMercury: pressureValue * 0.0295301,
                                    poundPerSquareInch: pressureValue * 0.0145038,
                                    ksi: pressureValue * 1.4503773773357e-8,
                                    torr: pressureValue * 0.750062,
                                    centimeterOfWater: pressureValue * 1.01972,
                                    millimeterOfWater: pressureValue * 101.972,
                                    kilogramPerSquareMeter: pressureValue * 100,
                                    kilogramPerSquareCentimeter: pressureValue * 0.01,
                                    kilogramPerSquareMillimeter: pressureValue * 1e-5
                                };
                                break;
                            case "microbar":
                                result = {
                                    pascal: pressureValue * 1e-4,
                                    kilopascal: pressureValue * 1e-7,
                                    megapascal: pressureValue * 1e-10,
                                    gigapascal: pressureValue * 1e-13,
                                    atmosphere: pressureValue * 9.86923e-8,
                                    bar: pressureValue * 1e-7,
                                    millibar: pressureValue * 0.001,
                                    microbar: pressureValue,
                                    millimeterOfMercury: pressureValue * 7.50062e-7,
                                    inchOfMercury: pressureValue * 2.95301e-8,
                                    poundPerSquareInch: pressureValue * 1.4503773773357e-8,
                                    ksi: pressureValue * 1.4503773773357e-11,
                                    torr: pressureValue * 7.50062e-7,
                                    centimeterOfWater: pressureValue * 1.01972e-6,
                                    millimeterOfWater: pressureValue * 1.01972e-4,
                                    kilogramPerSquareMeter: pressureValue * 0.01,
                                    kilogramPerSquareCentimeter: pressureValue * 1e-7,
                                    kilogramPerSquareMillimeter: pressureValue * 1e-10
                                };
                                break;
                            case "millimeterOfMercury":
                                result = {
                                    pascal: pressureValue * 133.322,
                                    kilopascal: pressureValue * 0.133322,
                                    megapascal: pressureValue * 1.33322e-4,
                                    gigapascal: pressureValue * 1.33322e-7,
                                    atmosphere: pressureValue * 0.00131579,
                                    bar: pressureValue * 0.00133322,
                                    millibar: pressureValue * 1.33322,
                                    microbar: pressureValue * 133322,
                                    millimeterOfMercury: pressureValue,
                                    inchOfMercury: pressureValue * 0.0393701,
                                    poundPerSquareInch: pressureValue * 0.0193368,
                                    ksi: pressureValue * 1.9336809331707e-5,
                                    torr: pressureValue,
                                    centimeterOfWater: pressureValue * 13.5951,
                                    millimeterOfWater: pressureValue * 1359.51,
                                    kilogramPerSquareMeter: pressureValue * 133.322,
                                    kilogramPerSquareCentimeter: pressureValue * 0.00133322,
                                    kilogramPerSquareMillimeter: pressureValue * 1.33322e-6
                                };
                                break;
                            case "inchOfMercury":
                                result = {
                                    pascal: pressureValue * 3386.39,
                                    kilopascal: pressureValue * 3.38639,
                                    megapascal: pressureValue * 0.00338639,
                                    gigapascal: pressureValue * 3.38639e-6,
                                    atmosphere: pressureValue * 0.0334211,
                                    bar: pressureValue * 0.0338639,
                                    millibar: pressureValue * 33.8639,
                                    microbar: pressureValue * 3386390,
                                    millimeterOfMercury: pressureValue * 25.4,
                                    inchOfMercury: pressureValue,
                                    poundPerSquareInch: pressureValue * 0.491154,
                                    ksi: pressureValue * 4.9115400007248e-4,
                                    torr: pressureValue * 25,
                                    centimeterOfWater: pressureValue * 70.307,
                                    millimeterOfWater: pressureValue * 7030.7,
                                    kilogramPerSquareMeter: pressureValue * 3386.39,
                                    kilogramPerSquareCentimeter: pressureValue * 0.0338639,
                                    kilogramPerSquareMillimeter: pressureValue * 3.38639e-5
                                };
                                break;
                            case "poundPerSquareInch":
                                result = {
                                    pascal: pressureValue * 6894.76,
                                    kilopascal: pressureValue * 6.89476,
                                    megapascal: pressureValue * 0.00689476,
                                    gigapascal: pressureValue * 6.89476e-9,
                                    atmosphere: pressureValue * 0.0680459,
                                    bar: pressureValue * 0.0689476,
                                    millibar: pressureValue * 68.9476,
                                    microbar: pressureValue * 6894760,
                                    millimeterOfMercury: pressureValue * 51.7149,
                                    inchOfMercury: pressureValue * 2.03602,
                                    poundPerSquareInch: pressureValue,
                                    ksi: pressureValue * 0.001,
                                    torr: pressureValue * 51.7149,
                                    centimeterOfWater: pressureValue * 70.307,
                                    millimeterOfWater: pressureValue * 7030.7,
                                    kilogramPerSquareMeter: pressureValue * 6894.76,
                                    kilogramPerSquareCentimeter: pressureValue * 0.0689476,
                                    kilogramPerSquareMillimeter: pressureValue * 6.89476e-5
                                };
                                break;
                            case "ksi":
                                result = {
                                    pascal: pressureValue * 6894760,
                                    kilopascal: pressureValue * 6894.76,
                                    megapascal: pressureValue * 6.89476,
                                    gigapascal: pressureValue * 6.89476e-6,
                                    atmosphere: pressureValue * 68.0459,
                                    bar: pressureValue * 68.9476,
                                    millibar: pressureValue * 68947.6,
                                    microbar: pressureValue * 6.89476e9,
                                    millimeterOfMercury: pressureValue * 51714.9,
                                    inchOfMercury: pressureValue * 2036.02,
                                    poundPerSquareInch: pressureValue * 1000,
                                    ksi: pressureValue,
                                    torr: pressureValue * 51714.9,
                                    centimeterOfWater: pressureValue * 70307,
                                    millimeterOfWater: pressureValue * 7030700,
                                    kilogramPerSquareMeter: pressureValue * 6894760,
                                    kilogramPerSquareCentimeter: pressureValue * 68.9476,
                                    kilogramPerSquareMillimeter: pressureValue * 0.0689476
                                };
                                break;
                            case "torr":
                                result = {
                                    pascal: pressureValue * 133.322,
                                    kilopascal: pressureValue * 0.133322,
                                    megapascal: pressureValue * 1.33322e-4,
                                    gigapascal: pressureValue * 1.33322e-7,
                                    atmosphere: pressureValue * 0.00131579,
                                    bar: pressureValue * 0.00133322,
                                    millibar: pressureValue * 1.33322,
                                    microbar: pressureValue * 133322,
                                    millimeterOfMercury: pressureValue,
                                    inchOfMercury: pressureValue * 0.0393701,
                                    poundPerSquareInch: pressureValue * 0.0193368,
                                    ksi: pressureValue * 1.9336809331707e-5,
                                    torr: pressureValue,
                                    centimeterOfWater: pressureValue * 13.5951,
                                    millimeterOfWater: pressureValue * 1359.51,
                                    kilogramPerSquareMeter: pressureValue * 133.322,
                                    kilogramPerSquareCentimeter: pressureValue * 0.00133322,
                                    kilogramPerSquareMillimeter: pressureValue * 1.33322e-6
                                };
                                break;
                            case "centimeterOfWater":
                                result = {
                                    pascal: pressureValue * 98.0665,
                                    kilopascal: pressureValue * 0.0980665,
                                    megapascal: pressureValue * 9.80665e-5,
                                    gigapascal: pressureValue * 9.80665e-8,
                                    atmosphere: pressureValue * 0.000967841,
                                    bar: pressureValue * 0.000980665,
                                    millibar: pressureValue * 0.980665,
                                    microbar: pressureValue * 98066.5,
                                    millimeterOfMercury: pressureValue * 0.735559,
                                    inchOfMercury: pressureValue * 0.0289584,
                                    poundPerSquareInch: pressureValue * 0.0142233,
                                    ksi: pressureValue * 1.4223343312735e-5,
                                    torr: pressureValue * 0.735559,
                                    centimeterOfWater: pressureValue,
                                    millimeterOfWater: pressureValue * 1000,
                                    kilogramPerSquareMeter: pressureValue * 98.0665,
                                    kilogramPerSquareCentimeter: pressureValue * 0.000980665,
                                    kilogramPerSquareMillimeter: pressureValue * 9.80665e-7
                                };
                                break;
                            case "millimeterOfWater":
                                result = {
                                    pascal: pressureValue * 9.80665,
                                    kilopascal: pressureValue * 0.00980665,
                                    megapascal: pressureValue * 9.80665e-6,
                                    gigapascal: pressureValue * 9.80665e-9,
                                    atmosphere: pressureValue * 9.67419e-5,
                                    bar: pressureValue * 9.80665e-5,
                                    millibar: pressureValue * 0.0980665,
                                    microbar: pressureValue * 980.665,
                                    millimeterOfMercury: pressureValue * 0.0735559,
                                    inchOfMercury: pressureValue * 0.00289584,
                                    poundPerSquareInch: pressureValue * 0.00142233,
                                    ksi: pressureValue * 1.4223343312735e-6,
                                    torr: pressureValue * 0.0735559,
                                    centimeterOfWater: pressureValue * 0.001,
                                    millimeterOfWater: pressureValue,
                                    kilogramPerSquareMeter: pressureValue * 9.80665,
                                    kilogramPerSquareCentimeter: pressureValue * 9.80665e-6,
                                    kilogramPerSquareMillimeter: pressureValue * 9.80665e-9
                                };
                                break;
                            case "kilogramPerSquareMeter":
                                result = {
                                    pascal: pressureValue,
                                    kilopascal: pressureValue * 0.001,
                                    megapascal: pressureValue * 1e-6,
                                    gigapascal: pressureValue * 1e-9,
                                    atmosphere: pressureValue * 9.86923e-6,
                                    bar: pressureValue * 1e-5,
                                    millibar: pressureValue * 0.01,
                                    microbar: pressureValue * 100,
                                    millimeterOfMercury: pressureValue * 0.00750062,
                                    inchOfMercury: pressureValue * 0.0002953,
                                    poundPerSquareInch: pressureValue * 0.00014503773773359,
                                    ksi: pressureValue * 1.4503773773357e-7,
                                    torr: pressureValue * 0.00750062,
                                    centimeterOfWater: pressureValue * 0.101971621,
                                    millimeterOfWater: pressureValue * 10197.1621,
                                    kilogramPerSquareMeter: pressureValue,
                                    kilogramPerSquareCentimeter: pressureValue * 1e-4,
                                    kilogramPerSquareMillimeter: pressureValue * 1e-6
                                };
                                break;
                            case "kilogramPerSquareCentimeter":
                                result = {
                                    pascal: pressureValue * 1e4,
                                    kilopascal: pressureValue * 10,
                                    megapascal: pressureValue * 0.01,
                                    gigapascal: pressureValue * 1e-8,
                                    atmosphere: pressureValue * 0.0986923,
                                    bar: pressureValue * 0.1,
                                    millibar: pressureValue * 100,
                                    microbar: pressureValue * 1e8,
                                    millimeterOfMercury: pressureValue * 75.0062,
                                    inchOfMercury: pressureValue * 2.953e-3,
                                    poundPerSquareInch: pressureValue * 1.4503773773357e-3,
                                    ksi: pressureValue * 1.4503773773357e-6,
                                    torr: pressureValue * 75.0062,
                                    centimeterOfWater: pressureValue * 1019.71621,
                                    millimeterOfWater: pressureValue * 101971.621,
                                    kilogramPerSquareMeter: pressureValue * 1e4,
                                    kilogramPerSquareCentimeter: pressureValue,
                                    kilogramPerSquareMillimeter: pressureValue * 1e-3
                                };
                                break;
                            case "kilogramPerSquareMillimeter":
                                result = {
                                    pascal: pressureValue * 1e6,
                                    kilopascal: pressureValue * 1000,
                                    megapascal: pressureValue * 1,
                                    gigapascal: pressureValue * 1e-3,
                                    atmosphere: pressureValue * 0.00986923,
                                    bar: pressureValue * 0.01,
                                    millibar: pressureValue * 10000,
                                    microbar: pressureValue * 1e10,
                                    millimeterOfMercury: pressureValue * 7500.62,
                                    inchOfMercury: pressureValue * 0.2953,
                                    poundPerSquareInch: pressureValue * 0.14503773773359,
                                    ksi: pressureValue * 1.4503773773357e-7,
                                    torr: pressureValue * 7500.62,
                                    centimeterOfWater: pressureValue * 101971.621,
                                    millimeterOfWater: pressureValue * 1e6,
                                    kilogramPerSquareMeter: pressureValue * 1e6,
                                    kilogramPerSquareCentimeter: pressureValue * 0.001,
                                    kilogramPerSquareMillimeter: pressureValue
                                };
                                break;
                            default:
                                result = { error: "Invalid unit" };
                                break;
                        }

                        // Display the result
                        document.getElementById("pressureResult").innerHTML = "Result: " +
                            "Pascal: " + formatResult(result.pascal, notation, decimalPlaces) + " Pa<br>" +
                            "Kilopascal: " + formatResult(result.kilopascal, notation, decimalPlaces) + " kPa<br>" +
                            "Megapascal: " + formatResult(result.megapascal, notation, decimalPlaces) + " MPa<br>" +
                            "Gigapascal: " + formatResult(result.gigapascal, notation, decimalPlaces) + " GPa<br>" +
                            "Atmosphere: " + formatResult(result.atmosphere, notation, decimalPlaces) + " atm<br>" +
                            "Bar: " + formatResult(result.bar, notation, decimalPlaces) + " bar<br>" +
                            "Millibar: " + formatResult(result.millibar, notation, decimalPlaces) + " mbar<br>" +
                            "Microbar: " + formatResult(result.microbar, notation, decimalPlaces) + " µbar<br>" +
                            "Millimeter of Mercury: " + formatResult(result.millimeterOfMercury, notation, decimalPlaces) + " mmHg<br>" +
                            "Inch of Mercury: " + formatResult(result.inchOfMercury, notation, decimalPlaces) + " inHg<br>" +
                            "Pound per Square Inch: " + formatResult(result.poundPerSquareInch, notation, decimalPlaces) + " psi<br>" +
                            "Kilopound per Square Inch: " + formatResult(result.ksi, notation, decimalPlaces) + " ksi<br>" +
                            "Torr: " + formatResult(result.torr, notation, decimalPlaces) + " Torr<br>" +
                            "Centimeter of Water: " + formatResult(result.centimeterOfWater, notation, decimalPlaces) + " cmH₂O<br>" +
                            "Millimeter of Water: " + formatResult(result.millimeterOfWater, notation, decimalPlaces) + " mmH₂O<br>" +
                            "Kilogram-force per Square Meter: " + formatResult(result.kilogramPerSquareMeter, notation, decimalPlaces) + " kg/cm²<br>" +
                            "Kilogram-force per Square Centimeter: " + formatResult(result.kilogramPerSquareCentimeter, notation, decimalPlaces) + " kg/cm²<br>" +
                            "Kilogram-force per Square Millimeter: " + formatResult(result.kilogramPerSquareMillimeter, notation, decimalPlaces) + " kg/mm²<br>";

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                            }
                        }

                    }


                    function convertText() {
                        // Get user input
                        var inputText = document.getElementById("textInput").value;
                        var conversionType = document.getElementById("conversionType").value;

                        // Perform the conversion based on the selected type
                        var result;
                        switch (conversionType) {
                            case "upperCase":
                                result = inputText.toUpperCase();
                                break;
                            case "lowerCase":
                                result = inputText.toLowerCase();
                                break;
                            case "titleCase":
                                result = toTitleCase(inputText);
                                break;
                            case "sentenceCase":
                                result = toSentenceCase(inputText);
                                break;
                            case "capitalizedCase":
                                result = toCapitalizedCase(inputText);
                                break;
                            case "inverseCase":
                                result = inverseCase(inputText);
                                break;
                            case "normalizedSingleSpace":
                                result = normalizeText(inputText, 1);
                                break;
                            case "normalizedDoubleSpace":
                                result = normalizeText(inputText, 2);
                                break;
                            case "inverseString":
                                result = inverseString(inputText);
                                break;
                            default:
                                result = "Invalid conversion type";
                        }

                        // Display the result 
                        document.getElementById("convertedText").innerHTML = "Converted: " + result +
                            "<br>Word Count (Whole Word): " + countWords(result) +
                            "<br>Character Count (With Space): " + countCharactersWithSpace(result) +
                            "<br>Character Count (Without Space): " + countCharactersWithoutSpace(result) +
                            "<br>Space Count: " + countSpaces(result) +
                            "<br>Sentence Count: " + countSentences(result) +
                            "<br>Paragraph Count: " + countParagraphs(result) +
                            "<br>Special Character Count: " + countSpecialCharacters(result);
                    }

                    function toTitleCase(text) {
                        var prepositions = /^(a|am|an|and|as|at|but|by|for|from|in|nor|of|on|or|the|to|with|among|around|before|behind|below|beside|between|down|during|except|inside|into|like|near|off|over|past|since|through|throughout|until|unto|up|upon|via|within)$/i;
                        var conjunctions = /^(and|but|if|or)$/i;
                        var articles = /^(a|an|the)$/i;

                        return text.replace(/\w\S*/g, function (word, index) {
                            // Check if it's the first word or not a small word
                            if (index === 0 || (!prepositions.test(word.toLowerCase()) && !conjunctions.test(word.toLowerCase()) && !articles.test(word.toLowerCase()))) {
                                return word.charAt(0).toUpperCase() + word.substr(1).toLowerCase();
                            } else {
                                return word.toLowerCase();
                            }
                        });
                    }


                    function toSentenceCase(text) {
                        return text.replace(/(^\s*|\.\s*)\S/g, function (char) {
                            return char.toUpperCase();
                        });
                    }

                    function toCapitalizedCase(text) {
                        return text.replace(/(\b\w)/g, function (char) {
                            return char.toUpperCase();
                        });
                    }

                    function inverseCase(text) {
                        return text.split('').map(function (char) {
                            return char === char.toUpperCase() ? char.toLowerCase() : char.toUpperCase();
                        }).join('');
                    }

                    function normalizeText(text, spaceCount) {
                        if (spaceCount == 1) {
                            return text.replace(/\s+/g, ' ').replace(/([.!?])\s*/g, function (match, p1) {
                                return p1 + ' '.repeat(spaceCount);
                            });
                        } else if (spaceCount == 2) {
                            return text.replace(/\s+/g, ' ').replace(/([.!?])\s*/g, function (match, p1) {
                                return p1 + ' '.repeat(spaceCount);
                            });
                        }
                    }

                    function countWords(text) {
                        return text.split(/\s+/).filter(function (word) {
                            return word.length > 0;
                        }).length;
                    }

                    function countCharactersWithSpace(text) {
                        return text.length;
                    }

                    function countCharactersWithoutSpace(text) {
                        return text.replace(/\s+/g, '').length;
                    }

                    function countSpaces(text) {
                        return (text.match(/\s/g) || []).length;
                    }

                    function countSentences(text) {
                        return (text.match(/\.\s/g) || []).length + 1;
                    }

                    function countParagraphs(text) {
                        return (text.split(/\n\s*\n/).filter(function (paragraph) {
                            return paragraph.trim().length > 0;
                        })).length;
                    }

                    function countSpecialCharacters(text) {
                        return (text.match(/[^a-zA-Z0-9\s]/g) || []).length;
                    }

                    function inverseString(inputString) {
                        return inputString.split('').reverse().join('');
                    }


                    function convertSpeed() {
                        // Get user input
                        var speedValue = parseFloat(document.getElementById("speedValue").value);
                        var speedUnit = document.getElementById("speedUnit").value;
                        var notation = document.getElementById("speedNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("speedDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (speedUnit) {
                            case "meterPerSecond":
                                result = {
                                    meterPerSecond: speedValue,
                                    meterPerMinute: speedValue * 60,
                                    meterPerHour: speedValue * 3600,
                                    kilometerPerSecond: speedValue * 0.001,
                                    kilometerPerMinute: speedValue * 0.06,
                                    kilometerPerHour: speedValue * 3.6,
                                    centimeterPerSecond: speedValue * 100,
                                    centimeterPerMinute: speedValue * 6000,
                                    centimeterPerHour: speedValue * 360000,
                                    millimeterPerSecond: speedValue * 1000,
                                    millimeterPerMinute: speedValue * 60000,
                                    millimeterPerHour: speedValue * 3600000,
                                    milePerSecond: speedValue * 0.000621371,
                                    milePerMinute: speedValue * 0.0372823,
                                    milePerHour: speedValue * 2.23694,
                                    knot: speedValue * 1.94384,
                                    speedOfLight: speedValue * 3.335640951E-9,
                                    speedOfSound: speedValue * 0.00291545
                                };
                                break;
                            case "meterPerMinute":
                                result = {
                                    meterPerSecond: speedValue / 60,
                                    meterPerMinute: speedValue,
                                    meterPerHour: speedValue * 60,
                                    kilometerPerSecond: speedValue / 60000,
                                    kilometerPerMinute: speedValue / 1000,
                                    kilometerPerHour: speedValue * 0.06,
                                    centimeterPerSecond: speedValue * 1.66667,
                                    centimeterPerMinute: speedValue * 100,
                                    centimeterPerHour: speedValue * 6000,
                                    millimeterPerSecond: speedValue * 16.6667,
                                    millimeterPerMinute: speedValue * 1000,
                                    millimeterPerHour: speedValue * 60000,
                                    milePerSecond: speedValue / 3600,
                                    milePerMinute: speedValue * 0.000621371,
                                    milePerHour: speedValue * 0.0372823,
                                    knot: speedValue * 0.0323974,
                                    speedOfLight: speedValue * 5.559401586E-11,
                                    speedOfSound: speedValue * 4.8591e-5
                                };
                                break;

                            case "meterPerHour":
                                result = {
                                    meterPerSecond: speedValue / 3600,
                                    meterPerMinute: speedValue / 60,
                                    meterPerHour: speedValue,
                                    kilometerPerSecond: speedValue / 3600000,
                                    kilometerPerMinute: speedValue / 60000,
                                    kilometerPerHour: speedValue / 1000,
                                    centimeterPerSecond: speedValue * 0.0277778,
                                    centimeterPerMinute: speedValue * 1.66667,
                                    centimeterPerHour: speedValue * 100,
                                    millimeterPerSecond: speedValue * 0.000277778,
                                    millimeterPerMinute: speedValue * 0.0166667,
                                    millimeterPerHour: speedValue * 1,
                                    milePerSecond: speedValue / 1609.34,
                                    milePerMinute: speedValue / 26.8224,
                                    milePerHour: speedValue * 0.000621371,
                                    knot: speedValue * 0.000539957,
                                    speedOfLight: speedValue * 9.265669311E-13,
                                    speedOfSound: speedValue * 8.09848e-7
                                };
                                break;

                            case "kilometerPerSecond":
                                result = {
                                    meterPerSecond: speedValue * 1000,
                                    meterPerMinute: speedValue * 60000,
                                    meterPerHour: speedValue * 3600000,
                                    kilometerPerSecond: speedValue,
                                    kilometerPerMinute: speedValue * 60,
                                    kilometerPerHour: speedValue * 3600,
                                    centimeterPerSecond: speedValue * 100000,
                                    centimeterPerMinute: speedValue * 6000000,
                                    centimeterPerHour: speedValue * 360000000,
                                    millimeterPerSecond: speedValue * 1e+6,
                                    millimeterPerMinute: speedValue * 6e+7,
                                    millimeterPerHour: speedValue * 3.6e+9,
                                    milePerSecond: speedValue * 0.621371,
                                    milePerMinute: speedValue * 37.2823,
                                    milePerHour: speedValue * 2236.94,
                                    knot: speedValue * 1943.84,
                                    speedOfLight: speedValue * 0.0000033356,
                                    speedOfSound: speedValue * 2.91545
                                };
                                break;

                            case "kilometerPerMinute":
                                result = {
                                    meterPerSecond: speedValue * 16.6667,
                                    meterPerMinute: speedValue * 1000,
                                    meterPerHour: speedValue * 60000,
                                    kilometerPerSecond: speedValue * 0.0166667,
                                    kilometerPerMinute: speedValue,
                                    kilometerPerHour: speedValue * 60,
                                    centimeterPerSecond: speedValue * 1666.67,
                                    centimeterPerMinute: speedValue * 100000,
                                    centimeterPerHour: speedValue * 6000000,
                                    millimeterPerSecond: speedValue * 16666.7,
                                    millimeterPerMinute: speedValue * 1e+6,
                                    millimeterPerHour: speedValue * 6e+7,
                                    milePerSecond: speedValue * 0.0109361,
                                    milePerMinute: speedValue * 0.656167,
                                    milePerHour: speedValue * 39.3701,
                                    knot: speedValue * 34.3981,
                                    speedOfLight: speedValue * 5.559401586E-8,
                                    speedOfSound: speedValue * 0.0485909
                                };
                                break;

                            case "kilometerPerHour":
                                result = {
                                    meterPerSecond: speedValue * 0.277778,
                                    meterPerMinute: speedValue * 16.6667,
                                    meterPerHour: speedValue * 1000,
                                    kilometerPerSecond: speedValue * 0.000277778,
                                    kilometerPerMinute: speedValue * 0.0166667,
                                    kilometerPerHour: speedValue,
                                    centimeterPerSecond: speedValue * 27.7778,
                                    centimeterPerMinute: speedValue * 1666.67,
                                    centimeterPerHour: speedValue * 100000,
                                    millimeterPerSecond: speedValue * 277.778,
                                    millimeterPerMinute: speedValue * 16666.7,
                                    millimeterPerHour: speedValue * 1e+6,
                                    milePerSecond: speedValue * 0.000172603,
                                    milePerMinute: speedValue * 0.0103562,
                                    milePerHour: speedValue * 0.621371,
                                    knot: speedValue * 0.539957,
                                    speedOfLight: speedValue * 9.265669311E-10,
                                    speedOfSound: speedValue * 0.000809848
                                };
                                break;
                            case "centimeterPerSecond":
                                result = {
                                    meterPerSecond: speedValue * 0.01,
                                    meterPerMinute: speedValue * 0.6,
                                    meterPerHour: speedValue * 36,
                                    kilometerPerSecond: speedValue * 1.0e-5,
                                    kilometerPerMinute: speedValue * 6.0e-4,
                                    kilometerPerHour: speedValue * 0.036,
                                    centimeterPerSecond: speedValue,
                                    centimeterPerMinute: speedValue * 60,
                                    centimeterPerHour: speedValue * 3600,
                                    millimeterPerSecond: speedValue * 0.1,
                                    millimeterPerMinute: speedValue * 6,
                                    millimeterPerHour: speedValue * 360,
                                    milePerSecond: speedValue * 2.23694e-6,
                                    milePerMinute: speedValue * 0.0000372823,
                                    milePerHour: speedValue * 0.00223694,
                                    knot: speedValue * 0.0194384,
                                    speedOfLight: speedValue * 3.335640951E-11,
                                    speedOfSound: speedValue * 2.91545e-5
                                };
                                break;

                            case "centimeterPerMinute":
                                result = {
                                    meterPerSecond: speedValue * 0.000166667,
                                    meterPerMinute: speedValue * 0.01,
                                    meterPerHour: speedValue * 0.6,
                                    kilometerPerSecond: speedValue * 1.66667e-8,
                                    kilometerPerMinute: speedValue * 1.0e-6,
                                    kilometerPerHour: speedValue * 0.000060,
                                    centimeterPerSecond: speedValue * 0.0166667,
                                    centimeterPerMinute: speedValue,
                                    centimeterPerHour: speedValue * 60,
                                    millimeterPerSecond: speedValue * 0.000166667,
                                    millimeterPerMinute: speedValue * 0.01,
                                    millimeterPerHour: speedValue * 0.6,
                                    milePerSecond: speedValue * 3.93701e-8,
                                    milePerMinute: speedValue * 6.56168e-7,
                                    milePerHour: speedValue * 0.0000372823,
                                    knot: speedValue * 0.000322738,
                                    speedOfLight: speedValue * 5.559401586E-13,
                                    speedOfSound: speedValue * 4.85909e-7
                                };
                                break;

                            case "centimeterPerHour":
                                result = {
                                    meterPerSecond: speedValue * 2.77778e-6,
                                    meterPerMinute: speedValue * 0.000166667,
                                    meterPerHour: speedValue * 0.01,
                                    kilometerPerSecond: speedValue * 2.77778e-11,
                                    kilometerPerMinute: speedValue * 1.66667e-9,
                                    kilometerPerHour: speedValue * 6.0e-7,
                                    centimeterPerSecond: speedValue * 2.77778e-4,
                                    centimeterPerMinute: speedValue * 0.0166667,
                                    centimeterPerHour: speedValue,
                                    millimeterPerSecond: speedValue * 2.77778e-6,
                                    millimeterPerMinute: speedValue * 0.000166667,
                                    millimeterPerHour: speedValue * 0.01,
                                    milePerSecond: speedValue * 6.56168e-12,
                                    milePerMinute: speedValue * 1.09361e-10,
                                    milePerHour: speedValue * 6.21371e-9,
                                    knot: speedValue * 5.39957e-8,
                                    speedOfLight: speedValue * 9.265669311E-15,
                                    speedOfSound: speedValue * 8.09848e-9
                                };
                                break;

                            case "millimeterPerSecond":
                                result = {
                                    meterPerSecond: speedValue * 0.001,
                                    meterPerMinute: speedValue * 0.06,
                                    meterPerHour: speedValue * 3.6,
                                    kilometerPerSecond: speedValue * 1.0e-6,
                                    kilometerPerMinute: speedValue * 6.0e-5,
                                    kilometerPerHour: speedValue * 0.0036,
                                    centimeterPerSecond: speedValue * 0.1,
                                    centimeterPerMinute: speedValue * 6,
                                    centimeterPerHour: speedValue * 360,
                                    millimeterPerSecond: speedValue,
                                    millimeterPerMinute: speedValue * 60,
                                    millimeterPerHour: speedValue * 3600,
                                    milePerSecond: speedValue * 2.23694e-7,
                                    milePerMinute: speedValue * 3.72823e-6,
                                    milePerHour: speedValue * 0.00000223694,
                                    knot: speedValue * 0.00194384,
                                    speedOfLight: speedValue * 3.335640951E-12,
                                    speedOfSound: speedValue * 2.91545e-6
                                };
                                break;


                            case "millimeterPerMinute":
                                result = {
                                    meterPerSecond: speedValue * 0.0000166667,
                                    meterPerMinute: speedValue * 0.001,
                                    meterPerHour: speedValue * 0.06,
                                    kilometerPerSecond: speedValue * 1.66667e-9,
                                    kilometerPerMinute: speedValue * 1.0e-7,
                                    kilometerPerHour: speedValue * 3.6e-6,
                                    centimeterPerSecond: speedValue * 0.0001,
                                    centimeterPerMinute: speedValue * 0.1,
                                    centimeterPerHour: speedValue * 6,
                                    millimeterPerSecond: speedValue * 0.001,
                                    millimeterPerMinute: speedValue,
                                    millimeterPerHour: speedValue * 60,
                                    milePerSecond: speedValue * 3.93701e-10,
                                    milePerMinute: speedValue * 6.56168e-9,
                                    milePerHour: speedValue * 3.725e-7,
                                    knot: speedValue * 3.22874e-6,
                                    speedOfLight: speedValue * 5.559401586E-14,
                                    speedOfSound: speedValue * 4.85909e-8
                                };
                                break;

                            case "millimeterPerHour":
                                result = {
                                    meterPerSecond: speedValue * 2.77778e-7,
                                    meterPerMinute: speedValue * 0.0000166667,
                                    meterPerHour: speedValue * 0.001,
                                    kilometerPerSecond: speedValue * 2.77778e-12,
                                    kilometerPerMinute: speedValue * 1.66667e-10,
                                    kilometerPerHour: speedValue * 3.6e-9,
                                    centimeterPerSecond: speedValue * 0.00000277778,
                                    centimeterPerMinute: speedValue * 0.0001,
                                    centimeterPerHour: speedValue * 0.006,
                                    millimeterPerSecond: speedValue * 2.77778e-6,
                                    millimeterPerMinute: speedValue * 0.0001,
                                    millimeterPerHour: speedValue,
                                    milePerSecond: speedValue * 6.56168e-13,
                                    milePerMinute: speedValue * 1.09361e-11,
                                    milePerHour: speedValue * 6.21371e-10,
                                    knot: speedValue * 5.39957e-9,
                                    speedOfLight: speedValue * 9.265669311E-16,
                                    speedOfSound: speedValue * 8.09848e-10
                                };
                                break;

                            case "milePerSecond":
                                result = {
                                    meterPerSecond: speedValue * 1609.34,
                                    meterPerMinute: speedValue * 96560.6,
                                    meterPerHour: speedValue * 5793636,
                                    kilometerPerSecond: speedValue * 1.60934,
                                    kilometerPerMinute: speedValue * 96.5606,
                                    kilometerPerHour: speedValue * 5793.636,
                                    centimeterPerSecond: speedValue * 160934,
                                    centimeterPerMinute: speedValue * 9656060.6,
                                    centimeterPerHour: speedValue * 579363636,
                                    millimeterPerSecond: speedValue * 1609340,
                                    millimeterPerMinute: speedValue * 965606060.6,
                                    millimeterPerHour: speedValue * 57936363636,
                                    milePerSecond: speedValue,
                                    milePerMinute: speedValue * 60,
                                    milePerHour: speedValue * 3600,
                                    knot: speedValue * 1943.84,
                                    speedOfLight: speedValue * 0.0000053682,
                                    speedOfSound: speedValue * 4.69197
                                };
                                break;

                            case "milePerMinute":
                                result = {
                                    meterPerSecond: speedValue * 26.8224,
                                    meterPerMinute: speedValue * 1609.34,
                                    meterPerHour: speedValue * 96560.6,
                                    kilometerPerSecond: speedValue * 0.44704,
                                    kilometerPerMinute: speedValue * 26.8224,
                                    kilometerPerHour: speedValue * 1609.34,
                                    centimeterPerSecond: speedValue * 2682.24,
                                    centimeterPerMinute: speedValue * 160934,
                                    centimeterPerHour: speedValue * 9656060.6,
                                    millimeterPerSecond: speedValue * 26822.4,
                                    millimeterPerMinute: speedValue * 1609340,
                                    millimeterPerHour: speedValue * 965606060.6,
                                    milePerSecond: speedValue * 0.0166667,
                                    milePerMinute: speedValue,
                                    milePerHour: speedValue * 60,
                                    knot: speedValue * 32.3974,
                                    speedOfLight: speedValue * 8.94699e-8,
                                    speedOfSound: speedValue * 0.0781994,
                                };
                                break;

                            case "milePerHour":
                                result = {
                                    meterPerSecond: speedValue * 0.44704,
                                    meterPerMinute: speedValue * 26.8224,
                                    meterPerHour: speedValue * 1609.34,
                                    kilometerPerSecond: speedValue * 0.000277778,
                                    kilometerPerMinute: speedValue * 0.0166667,
                                    kilometerPerHour: speedValue * 1.60934,
                                    centimeterPerSecond: speedValue * 4470.4,
                                    centimeterPerMinute: speedValue * 268224,
                                    centimeterPerHour: speedValue * 16093400,
                                    millimeterPerSecond: speedValue * 44704,
                                    millimeterPerMinute: speedValue * 2682240,
                                    millimeterPerHour: speedValue * 1609340606,
                                    milePerSecond: speedValue * 0.000277778,
                                    milePerMinute: speedValue * 0.0166667,
                                    milePerHour: speedValue,
                                    knot: speedValue * 0.868976,
                                    speedOfLight: speedValue * 1.49116e-9,
                                    speedOfSound: speedValue * 0.00130332
                                };
                                break;

                            case "knot":
                                result = {
                                    meterPerSecond: speedValue * 0.514444,
                                    meterPerMinute: speedValue * 30.8667,
                                    meterPerHour: speedValue * 1852,
                                    kilometerPerSecond: speedValue * 0.000514444,
                                    kilometerPerMinute: speedValue * 0.0308667,
                                    kilometerPerHour: speedValue * 1.852,
                                    centimeterPerSecond: speedValue * 51.4444,
                                    centimeterPerMinute: speedValue * 3086.67,
                                    centimeterPerHour: speedValue * 185200,
                                    millimeterPerSecond: speedValue * 514.444,
                                    millimeterPerMinute: speedValue * 30866.7,
                                    millimeterPerHour: speedValue * 1852000,
                                    milePerSecond: speedValue * 0.000319661,
                                    milePerMinute: speedValue * 0.0191797,
                                    milePerHour: speedValue * 1.15078,
                                    knot: speedValue,
                                    speedOfLight: speedValue * 1.716e-9,
                                    speedOfSound: speedValue * 0.00149984
                                };
                                break;

                            case "speedOfLight":
                                result = {
                                    meterPerSecond: speedValue * 299792458,
                                    meterPerMinute: speedValue * 17987547480,
                                    meterPerHour: speedValue * 1079252848800,
                                    kilometerPerSecond: speedValue * 299792.458,
                                    kilometerPerMinute: speedValue * 17987547.48,
                                    kilometerPerHour: speedValue * 1079252848.8,
                                    centimeterPerSecond: speedValue * 29979245800,
                                    centimeterPerMinute: speedValue * 1798754748000,
                                    centimeterPerHour: speedValue * 107925284880000,
                                    millimeterPerSecond: speedValue * 299792458000,
                                    millimeterPerMinute: speedValue * 17987547480000,
                                    millimeterPerHour: speedValue * 1079252848799998,
                                    milePerSecond: speedValue * 186282.39705,
                                    milePerMinute: speedValue * 11176943.823,
                                    milePerHour: speedValue * 670616629.38,
                                    knot: speedValue * 582749918.36,
                                    speedOfLight: speedValue,
                                    speedOfSound: speedValue * 874030,
                                };
                                break;

                            case "speedOfSound":
                                result = {
                                    meterPerSecond: speedValue * 343.2,
                                    meterPerMinute: speedValue * 20580,
                                    meterPerHour: speedValue * 1.235e+6,
                                    kilometerPerSecond: speedValue * 0.343,
                                    kilometerPerMinute: speedValue * 20.58,
                                    kilometerPerHour: speedValue * 1234.8,
                                    centimeterPerSecond: speedValue * 34300,
                                    centimeterPerMinute: speedValue * 2.058e+6,
                                    centimeterPerHour: speedValue * 1.235e+8,
                                    millimeterPerSecond: speedValue * 343000,
                                    millimeterPerMinute: speedValue * 2.058e+7,
                                    millimeterPerHour: speedValue * 1.235e+9,
                                    milePerSecond: speedValue * 0.21313,
                                    milePerMinute: speedValue * 12.7878,
                                    milePerHour: speedValue * 767.269,
                                    knot: speedValue * 666.739,
                                    speedOfLight: speedValue * 1.14412e-6,
                                    speedOfSound: speedValue,
                                };
                                break;

                        }

                        // Display the result
                        document.getElementById("speedResult").innerHTML = "Result: " +
                            "Meter/Second: " + formatResult(result.meterPerSecond, notation, decimalPlaces) + " m/s<br>" +
                            "Meter/Minute: " + formatResult(result.meterPerMinute, notation, decimalPlaces) + " m/min<br>" +
                            "Meter/Hour: " + formatResult(result.meterPerHour, notation, decimalPlaces) + " m/h<br>" +
                            "Kilometer/Second: " + formatResult(result.kilometerPerSecond, notation, decimalPlaces) + " km/s<br>" +
                            "Kilometer/Minute: " + formatResult(result.kilometerPerMinute, notation, decimalPlaces) + " km/min<br>" +
                            "Kilometer/Hour: " + formatResult(result.kilometerPerHour, notation, decimalPlaces) + " km/h<br>" +
                            "Centimeter/Second: " + formatResult(result.centimeterPerSecond, notation, decimalPlaces) + " cm/s<br>" +
                            "Centimeter/Minute: " + formatResult(result.centimeterPerMinute, notation, decimalPlaces) + " cm/min<br>" +
                            "Centimeter/Hour: " + formatResult(result.centimeterPerHour, notation, decimalPlaces) + " cm/h<br>" +
                            "Millimeter/Second: " + formatResult(result.millimeterPerSecond, notation, decimalPlaces) + " mm/s<br>" +
                            "Millimeter/Minute: " + formatResult(result.millimeterPerMinute, notation, decimalPlaces) + " mm/min<br>" +
                            "Millimeter/Hour: " + formatResult(result.millimeterPerHour, notation, decimalPlaces) + " mm/h<br>" +
                            "Mile/Second: " + formatResult(result.milePerSecond, notation, decimalPlaces) + " mi/s<br>" +
                            "Mile/Minute: " + formatResult(result.milePerMinute, notation, decimalPlaces) + " mi/min<br>" +
                            "Mile/Hour: " + formatResult(result.milePerHour, notation, decimalPlaces) + " mi/h<br>" +
                            "Knot: " + formatResult(result.knot, notation, decimalPlaces) + " kn<br>" +
                            "Speed of Light: " + formatResult(result.speedOfLight, notation, decimalPlaces) + " <br>" +
                            "Speed of Sound: " + formatResult(result.speedOfSound, notation, decimalPlaces);

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                            }
                        }
                    }



                    function convertVolume() {
                        // Get user input
                        var volumeValue = parseFloat(document.getElementById("volumeValue").value);
                        var volumeUnit = document.getElementById("volumeUnit").value;
                        var notation = document.getElementById("volumeNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("volumeDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (volumeUnit) {
                            case "cubicMeter":
                                result = {
                                    cubicMeter: volumeValue,
                                    cubicKilometer: volumeValue * 1.E-9,
                                    cubicCentimeter: volumeValue * 1.0e6,
                                    cubicMillimeter: volumeValue * 1.0e9,
                                    cubicDecimeter: volumeValue * 1.0e3,
                                    liter: volumeValue * 1000,
                                    milliliter: volumeValue * 1.0e6,
                                    gallon: volumeValue * 264.17205236,
                                    quart: volumeValue * 1056.6882094,
                                    pint: volumeValue * 2113.3764189,
                                    cup: volumeValue * 4226.7528377,
                                    fluidOunce: volumeValue * 33814.022702,
                                    tablespoon: volumeValue * 67628.045404,
                                    teaspoon: volumeValue * 202884.13621,
                                    earthVolume: volumeValue * 9.233610341E-22
                                };
                                break;
                            case "cubicKilometer":
                                result = {
                                    cubicMeter: volumeValue * 1000000000,
                                    cubicKilometer: volumeValue,
                                    cubicCentimeter: volumeValue * 1000000000000000,
                                    cubicMillimeter: volumeValue * 1000000000000000000,
                                    cubicDecimeter: volumeValue * 1000000000000,
                                    liter: volumeValue * 1000000000000,
                                    milliliter: volumeValue * 1000000000000000,
                                    gallon: volumeValue * 264172052358,
                                    quart: volumeValue * 1056688209433,
                                    pint: volumeValue * 2113376418865,
                                    cup: volumeValue * 4226752837730,
                                    fluidOunce: volumeValue * 33814022701843,
                                    tablespoon: volumeValue * 67628045403686,
                                    teaspoon: volumeValue * 202884136211060,
                                    earthVolume: volumeValue * 9.233610341E-13
                                };
                                break;

                            case "cubicCentimeter":
                                result = {
                                    cubicMeter: volumeValue * 1.0e-6,
                                    cubicKilometer: volumeValue * 1.0e-15,
                                    cubicCentimeter: volumeValue,
                                    cubicMillimeter: volumeValue * 1000,
                                    cubicDecimeter: volumeValue * 0.001,
                                    liter: volumeValue * 0.001,
                                    milliliter: volumeValue,
                                    gallon: volumeValue * 0.00026417205236,
                                    quart: volumeValue * 0.0010566882094,
                                    pint: volumeValue * 0.0021133764189,
                                    cup: volumeValue * 0.0042267528377,
                                    fluidOunce: volumeValue * 0.033814022702,
                                    tablespoon: volumeValue * 0.067628045404,
                                    teaspoon: volumeValue * 0.20288413621,
                                    earthVolume: volumeValue * 9.233610341E-28
                                };
                                break;
                            case "cubicMillimeter":
                                result = {
                                    cubicMeter: volumeValue * 1.0e-9,
                                    cubicKilometer: volumeValue * 1.0e-18,
                                    cubicCentimeter: volumeValue * 0.001,
                                    cubicMillimeter: volumeValue,
                                    cubicDecimeter: volumeValue * 1.0e-6,
                                    liter: volumeValue * 1.0e-6,
                                    milliliter: volumeValue * 0.001,
                                    gallon: volumeValue * 2.64172052358e-7,
                                    quart: volumeValue * 1.05668820943e-6,
                                    pint: volumeValue * 2.11337641887e-6,
                                    cup: volumeValue * 4.22675283773e-6,
                                    fluidOunce: volumeValue * 3.3814022702e-5,
                                    tablespoon: volumeValue * 6.76280454037e-5,
                                    teaspoon: volumeValue * 0.00020288413621,
                                    earthVolume: volumeValue * 9.233610341E-31
                                };
                                break;
                            case "cubicDecimeter":
                                result = {
                                    cubicMeter: volumeValue * 0.001,
                                    cubicKilometer: volumeValue * 1.0e-12,
                                    cubicCentimeter: volumeValue * 1000,
                                    cubicMillimeter: volumeValue * 1.0e6,
                                    cubicDecimeter: volumeValue,
                                    liter: volumeValue,
                                    milliliter: volumeValue * 1000,
                                    gallon: volumeValue * 0.26417205236,
                                    quart: volumeValue * 1.0566882094,
                                    pint: volumeValue * 2.1133764189,
                                    cup: volumeValue * 4.2267528377,
                                    fluidOunce: volumeValue * 33.814022702,
                                    tablespoon: volumeValue * 67.628045404,
                                    teaspoon: volumeValue * 202.88413621,
                                    earthVolume: volumeValue * 9.233610341E-25
                                };
                                break;
                            case "liter":
                                result = {
                                    cubicMeter: volumeValue * 0.001,
                                    cubicKilometer: volumeValue * 1.0e-12,
                                    cubicCentimeter: volumeValue * 1000,
                                    cubicMillimeter: volumeValue * 1.0e6,
                                    cubicDecimeter: volumeValue,
                                    liter: volumeValue,
                                    milliliter: volumeValue * 1000,
                                    gallon: volumeValue * 0.26417205236,
                                    quart: volumeValue * 1.0566882094,
                                    pint: volumeValue * 2.1133764189,
                                    cup: volumeValue * 4.2267528377,
                                    fluidOunce: volumeValue * 33.814022702,
                                    tablespoon: volumeValue * 67.628045404,
                                    teaspoon: volumeValue * 202.88413621,
                                    earthVolume: volumeValue * 9.233610341E-25
                                };
                                break;
                            case "milliliter":
                                result = {
                                    cubicMeter: volumeValue * 1.0e-6,
                                    cubicKilometer: volumeValue * 1.0e-15,
                                    cubicCentimeter: volumeValue,
                                    cubicMillimeter: volumeValue * 1000,
                                    cubicDecimeter: volumeValue * 0.001,
                                    liter: volumeValue * 0.001,
                                    milliliter: volumeValue,
                                    gallon: volumeValue * 0.00026417205236,
                                    quart: volumeValue * 0.0010566882094,
                                    pint: volumeValue * 0.0021133764189,
                                    cup: volumeValue * 0.0042267528377,
                                    fluidOunce: volumeValue * 0.033814022702,
                                    tablespoon: volumeValue * 0.067628045404,
                                    teaspoon: volumeValue * 0.20288413621,
                                    earthVolume: volumeValue * 9.233610341E-28
                                };
                                break;
                            case "gallon":
                                result = {
                                    cubicMeter: volumeValue * 0.00378541,
                                    cubicKilometer: volumeValue * 9.081685e-13,
                                    cubicCentimeter: volumeValue * 3785.41,
                                    cubicMillimeter: volumeValue * 3.78541e6,
                                    cubicDecimeter: volumeValue * 3.78541,
                                    liter: volumeValue * 3.78541,
                                    milliliter: volumeValue * 3785.41,
                                    gallon: volumeValue,
                                    quart: volumeValue * 4,
                                    pint: volumeValue * 8,
                                    cup: volumeValue * 16,
                                    fluidOunce: volumeValue * 128,
                                    tablespoon: volumeValue * 256,
                                    teaspoon: volumeValue * 768,
                                    earthVolume: volumeValue * 3.495301739E-24
                                };
                                break;
                            case "quart":
                                result = {
                                    cubicMeter: volumeValue * 0.000946353,
                                    cubicKilometer: volumeValue * 2.270421e-13,
                                    cubicCentimeter: volumeValue * 946.353,
                                    cubicMillimeter: volumeValue * 946353.0,
                                    cubicDecimeter: volumeValue * 0.946353,
                                    liter: volumeValue * 0.946353,
                                    milliliter: volumeValue * 946.353,
                                    gallon: volumeValue * 0.25,
                                    quart: volumeValue,
                                    pint: volumeValue * 2,
                                    cup: volumeValue * 4,
                                    fluidOunce: volumeValue * 32,
                                    tablespoon: volumeValue * 64,
                                    teaspoon: volumeValue * 192,
                                    earthVolume: volumeValue * 8.738254349E-25
                                };
                                break;
                            case "pint":
                                result = {
                                    cubicMeter: volumeValue * 0.000473176,
                                    cubicKilometer: volumeValue * 1.13521e-13,
                                    cubicCentimeter: volumeValue * 473.176,
                                    cubicMillimeter: volumeValue * 473176.0,
                                    cubicDecimeter: volumeValue * 0.473176,
                                    liter: volumeValue * 0.473176,
                                    milliliter: volumeValue * 473.176,
                                    gallon: volumeValue * 0.125,
                                    quart: volumeValue * 0.5,
                                    pint: volumeValue,
                                    cup: volumeValue * 2,
                                    fluidOunce: volumeValue * 16,
                                    tablespoon: volumeValue * 32,
                                    teaspoon: volumeValue * 96,
                                    earthVolume: volumeValue * 4.369127174E-25
                                };
                                break;
                            case "cup":
                                result = {
                                    cubicMeter: volumeValue * 0.000236588,
                                    cubicKilometer: volumeValue * 5.67605e-14,
                                    cubicCentimeter: volumeValue * 236.588,
                                    cubicMillimeter: volumeValue * 236588.0,
                                    cubicDecimeter: volumeValue * 0.236588,
                                    liter: volumeValue * 0.236588,
                                    milliliter: volumeValue * 236.588,
                                    gallon: volumeValue * 0.0625,
                                    quart: volumeValue * 0.25,
                                    pint: volumeValue * 0.5,
                                    cup: volumeValue,
                                    fluidOunce: volumeValue * 8,
                                    tablespoon: volumeValue * 16,
                                    teaspoon: volumeValue * 48,
                                    earthVolume: volumeValue * 2.184563587E-25
                                };
                                break;
                            case "fluidOunce":
                                result = {
                                    cubicMeter: volumeValue * 2.95735e-5,
                                    cubicKilometer: volumeValue * 7.09294e-15,
                                    cubicCentimeter: volumeValue * 29.5735,
                                    cubicMillimeter: volumeValue * 29573.5,
                                    cubicDecimeter: volumeValue * 0.0295735,
                                    liter: volumeValue * 0.0295735,
                                    milliliter: volumeValue * 29.5735,
                                    gallon: volumeValue * 0.0078125,
                                    quart: volumeValue * 0.03125,
                                    pint: volumeValue * 0.0625,
                                    cup: volumeValue * 0.125,
                                    fluidOunce: volumeValue,
                                    tablespoon: volumeValue * 2,
                                    teaspoon: volumeValue * 6,
                                    earthVolume: volumeValue * 2.730704484E-26
                                };
                                break;
                            case "tablespoon":
                                result = {
                                    cubicMeter: volumeValue * 1.47868e-5,
                                    cubicKilometer: volumeValue * 3.54024e-15,
                                    cubicCentimeter: volumeValue * 14.7868,
                                    cubicMillimeter: volumeValue * 14786.8,
                                    cubicDecimeter: volumeValue * 0.0147868,
                                    liter: volumeValue * 0.0147868,
                                    milliliter: volumeValue * 14.7868,
                                    gallon: volumeValue * 0.00390625,
                                    quart: volumeValue * 0.015625,
                                    pint: volumeValue * 0.03125,
                                    cup: volumeValue * 0.0625,
                                    fluidOunce: volumeValue * 0.5,
                                    tablespoon: volumeValue,
                                    teaspoon: volumeValue * 3,
                                    earthVolume: volumeValue * 1.365352242E-26
                                };
                                break;
                            case "teaspoon":
                                result = {
                                    cubicMeter: volumeValue * 4.92892e-6,
                                    cubicKilometer: volumeValue * 1.18141e-15,
                                    cubicCentimeter: volumeValue * 4.92892,
                                    cubicMillimeter: volumeValue * 4928.92,
                                    cubicDecimeter: volumeValue * 0.00492892,
                                    liter: volumeValue * 0.00492892,
                                    milliliter: volumeValue * 4.92892,
                                    gallon: volumeValue * 0.00130208,
                                    quart: volumeValue * 0.00520833,
                                    pint: volumeValue * 0.0104167,
                                    cup: volumeValue * 0.0208333,
                                    fluidOunce: volumeValue * 0.166667,
                                    tablespoon: volumeValue * 0.333333,
                                    teaspoon: volumeValue,
                                    earthVolume: volumeValue * 4.55117414E-27
                                };
                                break;
                            case "earthVolume":
                                result = {
                                    cubicMeter: volumeValue * 1.08143e21,
                                    cubicKilometer: volumeValue * 1.08143e12,
                                    cubicCentimeter: volumeValue * 1.08143e27,
                                    cubicMillimeter: volumeValue * 1.08143e30,
                                    cubicDecimeter: volumeValue * 1.08143e24,
                                    liter: volumeValue * 1.08143e24,
                                    milliliter: volumeValue * 1.08143e27,
                                    gallon: volumeValue * 2.86738e23,
                                    quart: volumeValue * 1.14695e24,
                                    pint: volumeValue * 2.29391e24,
                                    cup: volumeValue * 4.58782e24,
                                    fluidOunce: volumeValue * 3.67026e25,
                                    tablespoon: volumeValue * 7.34052e25,
                                    teaspoon: volumeValue * 2.20216e26,
                                    earthVolume: volumeValue
                                };
                                break;


                        }

                        // Display the result
                        document.getElementById("volumeResult").innerHTML = "Result: " +
                            "Cubic Meter: " + formatResult(result.cubicMeter, notation, decimalPlaces) + " m³<br>" +
                            "Cubic Kilometer: " + formatResult(result.cubicKilometer, notation, decimalPlaces) + " km³<br>" +
                            "Cubic Centimeter: " + formatResult(result.cubicCentimeter, notation, decimalPlaces) + " cm³<br>" +
                            "Cubic Millimeter: " + formatResult(result.cubicMillimeter, notation, decimalPlaces) + " mm³<br>" +
                            "Cubic Decimeter: " + formatResult(result.cubicDecimeter, notation, decimalPlaces) + " dm³<br>" +
                            "Liter: " + formatResult(result.liter, notation, decimalPlaces) + " L<br>" +
                            "Milliliter: " + formatResult(result.milliliter, notation, decimalPlaces) + " ml<br>" +
                            "Gallon: " + formatResult(result.gallon, notation, decimalPlaces) + " gal<br>" +
                            "Quart: " + formatResult(result.quart, notation, decimalPlaces) + " qt<br>" +
                            "Pint: " + formatResult(result.pint, notation, decimalPlaces) + " pt<br>" +
                            "Cup: " + formatResult(result.cup, notation, decimalPlaces) + " cup<br>" +
                            "Fluid Ounce: " + formatResult(result.fluidOunce, notation, decimalPlaces) + " fl oz<br>" +
                            "Tablespoon: " + formatResult(result.tablespoon, notation, decimalPlaces) + "<br>" +
                            "Teaspoon: " + formatResult(result.teaspoon, notation, decimalPlaces) + "<br>" +
                            "Earth Volume: " + formatResult(result.earthVolume, notation, decimalPlaces);

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                    break;
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                    break;
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                                    break;
                            }
                        }

                    }

                    function convertTemperature() {
                        // Get user input
                        var tempValue = parseFloat(document.getElementById("tempValue").value);
                        var tempUnit = document.getElementById("tempUnit").value;
                        var notation = document.getElementById("tempNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("tempDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (tempUnit) {
                            case "celsius":
                                result = {
                                    celsius: tempValue,
                                    kelvin: tempValue + 273.15,
                                    fahrenheit: (tempValue * 9 / 5) + 32,
                                    rankine: (tempValue + 273.15) * 9 / 5,
                                    reaumur: tempValue * 4 / 5,
                                };
                                break;
                            case "kelvin":
                                result = {
                                    kelvin: tempValue,
                                    celsius: tempValue - 273.15,
                                    fahrenheit: (tempValue - 273.15) * 9 / 5 + 32,
                                    rankine: tempValue * 9 / 5,
                                    reaumur: (tempValue - 273.15) * 4 / 5,
                                };
                                break;
                            case "fahrenheit":
                                result = {
                                    fahrenheit: tempValue,
                                    celsius: (tempValue - 32) * 5 / 9,
                                    kelvin: (tempValue - 32) * 5 / 9 + 273.15,
                                    rankine: tempValue + 459.67,
                                    reaumur: (tempValue - 32) * 4 / 9,
                                };
                                break;
                            case "rankine":
                                result = {
                                    rankine: tempValue,
                                    celsius: (tempValue - 491.67) * 5 / 9,
                                    kelvin: tempValue * 5 / 9,
                                    fahrenheit: tempValue - 459.67,
                                    reaumur: (tempValue - 491.67) * 4 / 9,
                                };
                                break;
                            case "reaumur":
                                result = {
                                    reaumur: tempValue,
                                    celsius: tempValue * 5 / 4,
                                    kelvin: tempValue * 5 / 4 + 273.15,
                                    fahrenheit: tempValue * 9 / 4 + 32,
                                    rankine: tempValue * 5 / 4 + 491.67,
                                };
                                break;
                        }

                        // Display the result
                        document.getElementById("tempResult").innerHTML = "Result: " +
                            "Celsius: " + formatResult(result.celsius, notation, decimalPlaces) + " °C<br>" +
                            "Kelvin: " + formatResult(result.kelvin, notation, decimalPlaces) + " K<br>" +
                            "Fahrenheit: " + formatResult(result.fahrenheit, notation, decimalPlaces) + " °F<br>" +
                            "Rankine: " + formatResult(result.rankine, notation, decimalPlaces) + " °R<br>" +
                            "Reaumur: " + formatResult(result.reaumur, notation, decimalPlaces) + " °Re<br>";
                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                    break;
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                    break;
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                                    break;
                            }
                        }
                    }

                    function convertArea() {
                        // Get user input
                        var areaValue = parseFloat(document.getElementById("areaValue").value);
                        var areaUnit = document.getElementById("areaUnit").value;
                        var notation = document.getElementById("areaNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("areaDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (areaUnit) {
                            case "squareMeter":
                                result = {
                                    squareMeter: areaValue,
                                    squareKilometer: areaValue * 0.000001,
                                    squareCentimeter: areaValue * 10000,
                                    squareMillimeter: areaValue * 1000000,
                                    squareMicrometer: areaValue * 1000000000000,
                                    acre: areaValue * 0.0002471054,
                                    hectare: areaValue * 0.0001,
                                    squareMile: areaValue * 3.861021585E-7,
                                    squareYard: areaValue * 1.1959900463,
                                    squareFoot: areaValue * 10.763910417,
                                    squareInch: areaValue * 1550.0031,
                                    squareHectometer: areaValue * 0.0001,
                                    squareDekameter: areaValue * 0.01,
                                    squareDecimeter: areaValue * 100,
                                    squareNanometer: areaValue * 1000000000000000000
                                };
                                break;
                            case "squareKilometer":
                                result = {
                                    squareMeter: areaValue * 1e+6,
                                    squareKilometer: areaValue,
                                    squareCentimeter: areaValue * 1e+10,
                                    squareMillimeter: areaValue * 1e+12,
                                    squareMicrometer: areaValue * 1e+18,
                                    acre: areaValue * 247.1053815,
                                    hectare: areaValue * 100,
                                    squareMile: areaValue * 0.2399131206,
                                    squareYard: areaValue * 1195990.0463,
                                    squareFoot: areaValue * 10763910.417,
                                    squareInch: areaValue * 1550003100,
                                    squareHectometer: areaValue * 100,
                                    squareDekameter: areaValue * 10000,
                                    squareDecimeter: areaValue * 100000000,
                                    squareNanometer: areaValue * 1e+24
                                };
                                break;

                            case "squareCentimeter":
                                result = {
                                    squareMeter: areaValue * 1e-4,
                                    squareKilometer: areaValue * 1e-10,
                                    squareCentimeter: areaValue,
                                    squareMillimeter: areaValue * 100,
                                    squareMicrometer: areaValue * 1e+8,
                                    acre: areaValue * 2.4710538147e-8,
                                    hectare: areaValue * 1e-8,
                                    squareMile: areaValue * 3.861e-11,
                                    squareYard: areaValue * 0.000119599,
                                    squareFoot: areaValue * 0.001076391,
                                    squareInch: areaValue * 0.15500031,
                                    squareHectometer: areaValue * 1e-10,
                                    squareDekameter: areaValue * 1e-8,
                                    squareDecimeter: areaValue * 10,
                                    squareNanometer: areaValue * 1e+14
                                };
                                break;

                            case "squareMillimeter":
                                result = {
                                    squareMeter: areaValue * 1e-6,
                                    squareKilometer: areaValue * 1e-12,
                                    squareCentimeter: areaValue * 0.01,
                                    squareMillimeter: areaValue,
                                    squareMicrometer: areaValue * 1e+6,
                                    acre: areaValue * 2.4710538147e-10,
                                    hectare: areaValue * 1e-10,
                                    squareMile: areaValue * 3.861e-13,
                                    squareYard: areaValue * 0.00000119599,
                                    squareFoot: areaValue * 0.00001076391,
                                    squareInch: areaValue * 0.0015500031,
                                    squareHectometer: areaValue * 1e-12,
                                    squareDekameter: areaValue * 1e-10,
                                    squareDecimeter: areaValue * 0.1,
                                    squareNanometer: areaValue * 1e+12
                                };
                                break;

                            case "squareMicrometer":
                                result = {
                                    squareMeter: areaValue * 1e-12,
                                    squareKilometer: areaValue * 1e-18,
                                    squareCentimeter: areaValue * 1e-8,
                                    squareMillimeter: areaValue * 1e-6,
                                    squareMicrometer: areaValue,
                                    acre: areaValue * 2.4710538147e-16,
                                    hectare: areaValue * 1e-16,
                                    squareMile: areaValue * 3.861e-19,
                                    squareYard: areaValue * 1.1959900463e-9,
                                    squareFoot: areaValue * 1.0763910417e-8,
                                    squareInch: areaValue * 1.5500031e-6,
                                    squareHectometer: areaValue * 1e-16,
                                    squareDekameter: areaValue * 1e-14,
                                    squareDecimeter: areaValue * 1e-4,
                                    squareNanometer: areaValue * 1e+6
                                };
                                break;

                            case "acre":
                                result = {
                                    squareMeter: areaValue * 4046.8564224,
                                    squareKilometer: areaValue * 4.0468564224e-6,
                                    squareCentimeter: areaValue * 40468564.224,
                                    squareMillimeter: areaValue * 4046856422.4,
                                    squareMicrometer: areaValue * 4.0468564224e+15,
                                    acre: areaValue,
                                    hectare: areaValue * 0.4046856422,
                                    squareMile: areaValue * 0.0015625,
                                    squareYard: areaValue * 4840,
                                    squareFoot: areaValue * 43560,
                                    squareInch: areaValue * 6272640,
                                    squareHectometer: areaValue * 0.0040468564,
                                    squareDekameter: areaValue * 40.468564224,
                                    squareDecimeter: areaValue * 404685.64224,
                                    squareNanometer: areaValue * 4.0468564224e+24
                                };
                                break;

                            case "hectare":
                                result = {
                                    squareMeter: areaValue * 10000,
                                    squareKilometer: areaValue * 1e-4,
                                    squareCentimeter: areaValue * 100000000,
                                    squareMillimeter: areaValue * 10000000000,
                                    squareMicrometer: areaValue * 1e+16,
                                    acre: areaValue * 2.4710538147,
                                    hectare: areaValue,
                                    squareMile: areaValue * 0.003861e-2,
                                    squareYard: areaValue * 11959.900463,
                                    squareFoot: areaValue * 107639.10417,
                                    squareInch: areaValue * 15500031,
                                    squareHectometer: areaValue * 0.01,
                                    squareDekameter: areaValue * 100,
                                    squareDecimeter: areaValue * 1000000,
                                    squareNanometer: areaValue * 1e+22
                                };
                                break;

                            case "squareMile":
                                result = {
                                    squareMeter: areaValue * 2.5899881103e+6,
                                    squareKilometer: areaValue * 2.5899881103,
                                    squareCentimeter: areaValue * 2.5899881103e+13,
                                    squareMillimeter: areaValue * 2.5899881103e+15,
                                    squareMicrometer: areaValue * 2.5899881103e+21,
                                    acre: areaValue * 640,
                                    hectare: areaValue * 259.98811034,
                                    squareMile: areaValue,
                                    squareYard: areaValue * 3097600,
                                    squareFoot: areaValue * 27878400,
                                    squareInch: areaValue * 4014489600,
                                    squareHectometer: areaValue * 2.5899881103e-2,
                                    squareDekameter: areaValue * 25899.8811034,
                                    squareDecimeter: areaValue * 25899881.1034,
                                    squareNanometer: areaValue * 2.5899881103e+24
                                };
                                break;

                            case "squareYard":
                                result = {
                                    squareMeter: areaValue * 0.83612736,
                                    squareKilometer: areaValue * 8.3612736e-7,
                                    squareCentimeter: areaValue * 8361.2736,
                                    squareMillimeter: areaValue * 836127.36,
                                    squareMicrometer: areaValue * 8.3612736e+14,
                                    acre: areaValue * 0.0002066116,
                                    hectare: areaValue * 8.3612736e-5,
                                    squareMile: areaValue * 3.2283057851e-7,
                                    squareYard: areaValue,
                                    squareFoot: areaValue * 9,
                                    squareInch: areaValue * 1296,
                                    squareHectometer: areaValue * 8.3612736e-6,
                                    squareDekameter: areaValue * 0.0000836127,
                                    squareDecimeter: areaValue * 8361.2736,
                                    squareNanometer: areaValue * 8.3612736e+18
                                };
                                break;

                            case "squareFoot":
                                result = {
                                    squareMeter: areaValue * 0.09290304,
                                    squareKilometer: areaValue * 9.290304e-8,
                                    squareCentimeter: areaValue * 929.0304,
                                    squareMillimeter: areaValue * 92903.04,
                                    squareMicrometer: areaValue * 9.290304e+13,
                                    acre: areaValue * 2.2956841139e-5,
                                    hectare: areaValue * 9.290304e-6,
                                    squareMile: areaValue * 3.5870064279e-8,
                                    squareYard: areaValue * 0.1111111111,
                                    squareFoot: areaValue,
                                    squareInch: areaValue * 144,
                                    squareHectometer: areaValue * 9.290304e-7,
                                    squareDekameter: areaValue * 9.290304e-5,
                                    squareDecimeter: areaValue * 929.0304,
                                    squareNanometer: areaValue * 9.290304e+17
                                };
                                break;

                            case "squareInch":
                                result = {
                                    squareMeter: areaValue * 0.00064516,
                                    squareKilometer: areaValue * 6.4516e-10,
                                    squareCentimeter: areaValue * 6.4516,
                                    squareMillimeter: areaValue * 645.16,
                                    squareMicrometer: areaValue * 6.4516e+11,
                                    acre: areaValue * 1.5942250791e-7,
                                    hectare: areaValue * 6.4516e-8,
                                    squareMile: areaValue * 2.4909766861e-10,
                                    squareYard: areaValue * 0.0007716049,
                                    squareFoot: areaValue * 0.0069444444,
                                    squareInch: areaValue,
                                    squareHectometer: areaValue * 6.4516e-9,
                                    squareDekameter: areaValue * 6.4516e-7,
                                    squareDecimeter: areaValue * 64.516,
                                    squareNanometer: areaValue * 6.4516e+14
                                };
                                break;

                            case "squareHectometer":
                                result = {
                                    squareMeter: areaValue * 10000,
                                    squareKilometer: areaValue * 0.01,
                                    squareCentimeter: areaValue * 1e+8,
                                    squareMillimeter: areaValue * 1e+10,
                                    squareMicrometer: areaValue * 1e+16,
                                    acre: areaValue * 2.4710538147,
                                    hectare: areaValue * 0.01,
                                    squareMile: areaValue * 3.861e-3,
                                    squareYard: areaValue * 11959.900463,
                                    squareFoot: areaValue * 107639.10417,
                                    squareInch: areaValue * 15500031,
                                    squareHectometer: areaValue,
                                    squareDekameter: areaValue * 100,
                                    squareDecimeter: areaValue * 1000000,
                                    squareNanometer: areaValue * 1e+22
                                };
                                break;

                            case "squareDekameter":
                                result = {
                                    squareMeter: areaValue * 100,
                                    squareKilometer: areaValue * 1e-4,
                                    squareCentimeter: areaValue * 1e+6,
                                    squareMillimeter: areaValue * 1e+8,
                                    squareMicrometer: areaValue * 1e+14,
                                    acre: areaValue * 2.4710538147e-2,
                                    hectare: areaValue * 0.01,
                                    squareMile: areaValue * 3.861e-5,
                                    squareYard: areaValue * 1195.9900463,
                                    squareFoot: areaValue * 10763.910417,
                                    squareInch: areaValue * 1550003.1,
                                    squareHectometer: areaValue * 0.1,
                                    squareDekameter: areaValue,
                                    squareDecimeter: areaValue * 10000,
                                    squareNanometer: areaValue * 1e+20
                                };
                                break;

                            case "squareDecimeter":
                                result = {
                                    squareMeter: areaValue * 0.1,
                                    squareKilometer: areaValue * 1e-7,
                                    squareCentimeter: areaValue * 100,
                                    squareMillimeter: areaValue * 1000,
                                    squareMicrometer: areaValue * 1e+10,
                                    acre: areaValue * 2.4710538147e-5,
                                    hectare: areaValue * 1e-4,
                                    squareMile: areaValue * 3.861e-8,
                                    squareYard: areaValue * 0.1195990046,
                                    squareFoot: areaValue * 1.0763910417,
                                    squareInch: areaValue * 155.00031,
                                    squareHectometer: areaValue * 1e-6,
                                    squareDekameter: areaValue * 0.0001,
                                    squareDecimeter: areaValue,
                                    squareNanometer: areaValue * 1e+20
                                };
                                break;

                            case "squareNanometer":
                                result = {
                                    squareMeter: areaValue * 1e-18,
                                    squareKilometer: areaValue * 1e-24,
                                    squareCentimeter: areaValue * 1e-8,
                                    squareMillimeter: areaValue * 1e-6,
                                    squareMicrometer: areaValue * 0.001,
                                    acre: areaValue * 2.4710538147e-24,
                                    hectare: areaValue * 1e-22,
                                    squareMile: areaValue * 3.861e-25,
                                    squareYard: areaValue * 1.1959900463e-15,
                                    squareFoot: areaValue * 1.0763910417e-14,
                                    squareInch: areaValue * 1.5500031e-12,
                                    squareHectometer: areaValue * 1e-22,
                                    squareDekameter: areaValue * 1e-20,
                                    squareDecimeter: areaValue * 1e-16,
                                    squareNanometer: areaValue
                                };
                                break;
                        }

                        // Display the result
                        document.getElementById("areaResult").innerHTML = "Result: " +
                            "Square Meter: " + formatResult(result.squareMeter, notation, decimalPlaces) + " m²<br>" +
                            "Square Kilometer: " + formatResult(result.squareKilometer, notation, decimalPlaces) + " km²<br>" +
                            "Square Centimeter: " + formatResult(result.squareCentimeter, notation, decimalPlaces) + " cm²<br>" +
                            "Square Millimeter: " + formatResult(result.squareMillimeter, notation, decimalPlaces) + " mm²<br>" +
                            "Square Micrometer: " + formatResult(result.squareMicrometer, notation, decimalPlaces) + " µm²<br>" +
                            "Acre: " + formatResult(result.acre, notation, decimalPlaces) + " ac<br>" +
                            "Hectare: " + formatResult(result.hectare, notation, decimalPlaces) + " ha<br>" +
                            "Square Mile: " + formatResult(result.squareMile, notation, decimalPlaces) + " mi²<br>" +
                            "Square Yard: " + formatResult(result.squareYard, notation, decimalPlaces) + " yd²<br>" +
                            "Square Foot: " + formatResult(result.squareFoot, notation, decimalPlaces) + " ft²<br>" +
                            "Square Inch: " + formatResult(result.squareInch, notation, decimalPlaces) + " in²<br>" +
                            "Square Hectometer: " + formatResult(result.squareHectometer, notation, decimalPlaces) + " hm²<br>" +
                            "Square Dekameter: " + formatResult(result.squareDekameter, notation, decimalPlaces) + " dam²<br>" +
                            "Square Decimeter: " + formatResult(result.squareDecimeter, notation, decimalPlaces) + " dm²<br>" +
                            "Square Nanometer: " + formatResult(result.squareNanometer, notation, decimalPlaces) + " nm²";

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                    break;
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                    break;
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                                    break;
                            }
                        }
                    }

                    function convertWeight() {
                        // Get user input
                        var weightValue = parseFloat(document.getElementById("weightValue").value);
                        var weightUnit = document.getElementById("weightUnit").value;
                        var notation = document.getElementById("weightNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("weightDecimalPlaces").value);

                        // Perform the conversion 
                        var result;
                        switch (weightUnit) {
                            case "gram":
                                result = {
                                    gram: weightValue,
                                    kilogram: weightValue * 0.001,
                                    milligram: weightValue * 1000,
                                    decigram: weightValue * 10,
                                    centigram: weightValue * 100,
                                    metricTon: weightValue * 0.000001,
                                    longTon: weightValue * 9.842065276E-7,
                                    shortTon: weightValue * 0.0000011023,
                                    pound: weightValue * 0.0022046226,
                                    ounce: weightValue * 0.0352739619,
                                    carat: weightValue * 5,
                                    atomicMassUnit: weightValue * 6.022136651E+23,
                                    dalton: weightValue * 6.022173643E+23,
                                    gamma: weightValue * 1000000,
                                    planckMass: weightValue * 45940.892448,
                                    electronMass: weightValue * 1.097768382E+27,
                                    muonMass: weightValue * 5.309172492E+24,
                                    protonMass: weightValue * 5.978633201E+23,
                                    neutronMass: weightValue * 5.970403753E+23,
                                    deuteronMass: weightValue * 2.990800894E+23,
                                    earthMass: weightValue * 1.673360107E-28,
                                    sunMass: weightValue * 5.E-34
                                };
                                break;
                            case "kilogram":
                                result = {
                                    gram: weightValue * 1000,
                                    kilogram: weightValue,
                                    milligram: weightValue * 1e+6,
                                    decigram: weightValue * 10000,
                                    centigram: weightValue * 100000,
                                    metricTon: weightValue * 1e-3,
                                    longTon: weightValue * 0.0009842065,
                                    shortTon: weightValue * 0.00110231131,
                                    pound: weightValue * 2.20462262,
                                    ounce: weightValue * 35.2739619,
                                    carat: weightValue * 5000,
                                    atomicMassUnit: weightValue * 6.022136651e+26,
                                    dalton: weightValue * 6.022173643e+26,
                                    gamma: weightValue * 1e+9,
                                    planckMass: weightValue * 45940892.448,
                                    electronMass: weightValue * 1.097768382e+29,
                                    muonMass: weightValue * 5.309172492e+26,
                                    protonMass: weightValue * 5.978633201e+25,
                                    neutronMass: weightValue * 5.970403753e+25,
                                    deuteronMass: weightValue * 2.990800894e+25,
                                    earthMass: weightValue * 1.673360107e-25,
                                    sunMass: weightValue * 5e-31
                                };
                                break;
                            case "milligram":
                                result = {
                                    gram: weightValue * 0.001,
                                    kilogram: weightValue * 1e-6,
                                    milligram: weightValue,
                                    decigram: weightValue * 0.01,
                                    centigram: weightValue * 0.1,
                                    metricTon: weightValue * 1e-9,
                                    longTon: weightValue * 9.842065276e-10,
                                    shortTon: weightValue * 1.10231131e-9,
                                    pound: weightValue * 2.20462262e-6,
                                    ounce: weightValue * 3.52739619e-5,
                                    carat: weightValue * 0.005,
                                    atomicMassUnit: weightValue * 6.022136651e+20,
                                    dalton: weightValue * 6.022173643e+20,
                                    gamma: weightValue * 0.001,
                                    planckMass: weightValue * 45940.892448e-3,
                                    electronMass: weightValue * 1.097768382e+24,
                                    muonMass: weightValue * 5.309172492e+20,
                                    protonMass: weightValue * 5.978633201e+19,
                                    neutronMass: weightValue * 5.970403753e+19,
                                    deuteronMass: weightValue * 2.990800894e+19,
                                    earthMass: weightValue * 1.673360107e-31,
                                    sunMass: weightValue * 5e-37
                                };
                                break;
                            case "decigram":
                                result = {
                                    gram: weightValue * 0.1,
                                    kilogram: weightValue * 0.0001,
                                    milligram: weightValue * 100,
                                    decigram: weightValue,
                                    centigram: weightValue * 10,
                                    metricTon: weightValue * 1e-7,
                                    longTon: weightValue * 9.842065276e-8,
                                    shortTon: weightValue * 1.10231131e-7,
                                    pound: weightValue * 0.000220462262,
                                    ounce: weightValue * 0.00352739619,
                                    carat: weightValue * 0.5,
                                    atomicMassUnit: weightValue * 6.022136651e+22,
                                    dalton: weightValue * 6.022173643e+22,
                                    gamma: weightValue * 1000,
                                    planckMass: weightValue * 45.940892448,
                                    electronMass: weightValue * 1.097768382e+26,
                                    muonMass: weightValue * 5.309172492e+23,
                                    protonMass: weightValue * 5.978633201e+22,
                                    neutronMass: weightValue * 5.970403753e+22,
                                    deuteronMass: weightValue * 2.990800894e+22,
                                    earthMass: weightValue * 1.673360107e-27,
                                    sunMass: weightValue * 5e-33
                                };
                                break;
                            case "centigram":
                                result = {
                                    gram: weightValue * 0.01,
                                    kilogram: weightValue * 1e-5,
                                    milligram: weightValue * 10,
                                    decigram: weightValue * 0.1,
                                    centigram: weightValue,
                                    metricTon: weightValue * 1e-8,
                                    longTon: weightValue * 9.842065276e-9,
                                    shortTon: weightValue * 1.10231131e-8,
                                    pound: weightValue * 0.0000220462262,
                                    ounce: weightValue * 0.000352739619,
                                    carat: weightValue * 0.05,
                                    atomicMassUnit: weightValue * 6.022136651e+21,
                                    dalton: weightValue * 6.022173643e+21,
                                    gamma: weightValue * 10,
                                    planckMass: weightValue * 4.5940892448,
                                    electronMass: weightValue * 1.097768382e+25,
                                    muonMass: weightValue * 5.309172492e+22,
                                    protonMass: weightValue * 5.978633201e+21,
                                    neutronMass: weightValue * 5.970403753e+21,
                                    deuteronMass: weightValue * 2.990800894e+21,
                                    earthMass: weightValue * 1.673360107e-26,
                                    sunMass: weightValue * 5e-32
                                };
                                break;
                            case "metricTon":
                                result = {
                                    gram: weightValue * 1e6,
                                    kilogram: weightValue * 1000,
                                    milligram: weightValue * 1e9,
                                    decigram: weightValue * 1e7,
                                    centigram: weightValue * 1e8,
                                    metricTon: weightValue,
                                    longTon: weightValue * 0.9842065276,
                                    shortTon: weightValue * 1.10231131,
                                    pound: weightValue * 2204.62262,
                                    ounce: weightValue * 35273.9619,
                                    carat: weightValue * 5e6,
                                    atomicMassUnit: weightValue * 6.022136651e+29,
                                    dalton: weightValue * 6.022173643e+29,
                                    gamma: weightValue * 1e12,
                                    planckMass: weightValue * 459408924.48,
                                    electronMass: weightValue * 1.097768382e+33,
                                    muonMass: weightValue * 5.309172492e+30,
                                    protonMass: weightValue * 5.978633201e+29,
                                    neutronMass: weightValue * 5.970403753e+29,
                                    deuteronMass: weightValue * 2.990800894e+29,
                                    earthMass: weightValue * 1.673360107e-25,
                                    sunMass: weightValue * 5e-31
                                };
                                break;
                            case "longTon":
                                result = {
                                    gram: weightValue * 1016046.91,
                                    kilogram: weightValue * 1016.04691,
                                    milligram: weightValue * 1.01604691e9,
                                    decigram: weightValue * 1.01604691e7,
                                    centigram: weightValue * 1.01604691e8,
                                    metricTon: weightValue * 1.01604691,
                                    longTon: weightValue,
                                    shortTon: weightValue * 1.12,
                                    pound: weightValue * 2240,
                                    ounce: weightValue * 35840,
                                    carat: weightValue * 508023.456,
                                    atomicMassUnit: weightValue * 6.022136651e+29,
                                    dalton: weightValue * 6.022173643e+29,
                                    gamma: weightValue * 1e12,
                                    planckMass: weightValue * 459408924.48,
                                    electronMass: weightValue * 1.097768382e+33,
                                    muonMass: weightValue * 5.309172492e+30,
                                    protonMass: weightValue * 5.978633201e+29,
                                    neutronMass: weightValue * 5.970403753e+29,
                                    deuteronMass: weightValue * 2.990800894e+29,
                                    earthMass: weightValue * 1.673360107e-25,
                                    sunMass: weightValue * 5e-31
                                };
                                break;
                            case "shortTon":
                                result = {
                                    gram: weightValue * 907184.74,
                                    kilogram: weightValue * 907.18474,
                                    milligram: weightValue * 907184740,
                                    decigram: weightValue * 9071847.4,
                                    centigram: weightValue * 90718474,
                                    metricTon: weightValue * 0.90718474,
                                    longTon: weightValue * 0.892857143,
                                    shortTon: weightValue,
                                    pound: weightValue * 2000,
                                    ounce: weightValue * 32000,
                                    carat: weightValue * 4535923.7,
                                    atomicMassUnit: weightValue * 6.022136651e+29,
                                    dalton: weightValue * 6.022173643e+29,
                                    gamma: weightValue * 1e12,
                                    planckMass: weightValue * 459408924.48,
                                    electronMass: weightValue * 1.097768382e+33,
                                    muonMass: weightValue * 5.309172492e+30,
                                    protonMass: weightValue * 5.978633201e+29,
                                    neutronMass: weightValue * 5.970403753e+29,
                                    deuteronMass: weightValue * 2.990800894e+29,
                                    earthMass: weightValue * 1.673360107e-25,
                                    sunMass: weightValue * 5e-31
                                };
                                break;
                            case "pound":
                                result = {
                                    gram: weightValue * 453.59237,
                                    kilogram: weightValue * 0.45359237,
                                    milligram: weightValue * 453592.37,
                                    decigram: weightValue * 4535.9237,
                                    centigram: weightValue * 45359.237,
                                    metricTon: weightValue * 0.00045359237,
                                    longTon: weightValue * 0.000446428571,
                                    shortTon: weightValue * 0.0005,
                                    pound: weightValue,
                                    ounce: weightValue * 16,
                                    carat: weightValue * 2267.96185,
                                    atomicMassUnit: weightValue * 6.022136651e+26,
                                    dalton: weightValue * 6.022173643e+26,
                                    gamma: weightValue * 1e9,
                                    planckMass: weightValue * 459408924.48,
                                    electronMass: weightValue * 1.097768382e+30,
                                    muonMass: weightValue * 5.309172492e+27,
                                    protonMass: weightValue * 5.978633201e+26,
                                    neutronMass: weightValue * 5.970403753e+26,
                                    deuteronMass: weightValue * 2.990800894e+26,
                                    earthMass: weightValue * 1.673360107e-25,
                                    sunMass: weightValue * 5e-31
                                };
                                break;
                            case "ounce":
                                result = {
                                    gram: weightValue * 28.3495231,
                                    kilogram: weightValue * 0.0283495231,
                                    milligram: weightValue * 28349.5231,
                                    decigram: weightValue * 283.495231,
                                    centigram: weightValue * 2834.95231,
                                    metricTon: weightValue * 2.83495231e-5,
                                    longTon: weightValue * 2.79017857e-5,
                                    shortTon: weightValue * 3.125e-5,
                                    pound: weightValue * 0.0625,
                                    ounce: weightValue,
                                    carat: weightValue * 141.747615,
                                    atomicMassUnit: weightValue * 6.022136651e+25,
                                    dalton: weightValue * 6.022173643e+25,
                                    gamma: weightValue * 1e8,
                                    planckMass: weightValue * 459408924.48,
                                    electronMass: weightValue * 1.097768382e+29,
                                    muonMass: weightValue * 5.309172492e+26,
                                    protonMass: weightValue * 5.978633201e+25,
                                    neutronMass: weightValue * 5.970403753e+25,
                                    deuteronMass: weightValue * 2.990800894e+25,
                                    earthMass: weightValue * 1.673360107e-28,
                                    sunMass: weightValue * 5e-34
                                };
                                break;
                            case "carat":
                                result = {
                                    gram: weightValue * 0.2,
                                    kilogram: weightValue * 0.0002,
                                    milligram: weightValue * 200,
                                    decigram: weightValue * 2,
                                    centigram: weightValue * 20,
                                    metricTon: weightValue * 2e-7,
                                    longTon: weightValue * 1.96841316e-7,
                                    shortTon: weightValue * 2.20462262e-7,
                                    pound: weightValue * 0.000440924524,
                                    ounce: weightValue * 0.00705479239,
                                    carat: weightValue,
                                    atomicMassUnit: weightValue * 6.022136651e+22,
                                    dalton: weightValue * 6.022173643e+22,
                                    gamma: weightValue * 100,
                                    planckMass: weightValue * 4594089.2448,
                                    electronMass: weightValue * 1.097768382e+26,
                                    muonMass: weightValue * 5.309172492e+23,
                                    protonMass: weightValue * 5.978633201e+22,
                                    neutronMass: weightValue * 5.970403753e+22,
                                    deuteronMass: weightValue * 2.990800894e+22,
                                    earthMass: weightValue * 1.673360107e-29,
                                    sunMass: weightValue * 5e-35
                                };
                                break;

                            case "atomicMassUnit":
                                result = {
                                    gram: weightValue * 1.6605390666e-24,
                                    kilogram: weightValue * 1.6605390666e-27,
                                    milligram: weightValue * 1.6605390666e-21,
                                    decigram: weightValue * 1.6605390666e-25,
                                    centigram: weightValue * 1.6605390666e-24,
                                    metricTon: weightValue * 1.6605390666e-30,
                                    longTon: weightValue * 1.6331196618e-30,
                                    shortTon: weightValue * 1.8224624362e-30,
                                    pound: weightValue * 3.6608611631e-27,
                                    ounce: weightValue * 5.8573778609e-26,
                                    carat: weightValue * 1e-23,
                                    atomicMassUnit: weightValue,
                                    dalton: weightValue,
                                    gamma: weightValue * 1.6605390666e-18,
                                    planckMass: weightValue * 1.0149253733e-34,
                                    electronMass: weightValue * 2.731597071e-26,
                                    muonMass: weightValue * 1.315812815e-28,
                                    protonMass: weightValue * 1.4803945093e-27,
                                    neutronMass: weightValue * 1.4771089773e-27,
                                    deuteronMass: weightValue * 7.3720134128e-28,
                                    earthMass: weightValue * 4.4131632274e-55,
                                    sunMass: weightValue * 1.3271244e-58
                                };
                                break;

                            case "dalton":
                                result = {
                                    gram: weightValue * 1.6605390666e-24,
                                    kilogram: weightValue * 1.6605390666e-27,
                                    milligram: weightValue * 1.6605390666e-21,
                                    decigram: weightValue * 1.6605390666e-25,
                                    centigram: weightValue * 1.6605390666e-24,
                                    metricTon: weightValue * 1.6605390666e-30,
                                    longTon: weightValue * 1.6331196618e-30,
                                    shortTon: weightValue * 1.8224624362e-30,
                                    pound: weightValue * 3.6608611631e-27,
                                    ounce: weightValue * 5.8573778609e-26,
                                    carat: weightValue * 1e-23,
                                    atomicMassUnit: weightValue,
                                    dalton: weightValue,
                                    gamma: weightValue * 1.6605390666e-18,
                                    planckMass: weightValue * 1.0149253733e-34,
                                    electronMass: weightValue * 2.731597071e-26,
                                    muonMass: weightValue * 1.315812815e-28,
                                    protonMass: weightValue * 1.4803945093e-27,
                                    neutronMass: weightValue * 1.4771089773e-27,
                                    deuteronMass: weightValue * 7.3720134128e-28,
                                    earthMass: weightValue * 4.4131632274e-55,
                                    sunMass: weightValue * 1.3271244e-58
                                };
                                break;
                            case "gamma":
                                result = {
                                    gram: weightValue * 1e-6,
                                    kilogram: weightValue * 1e-9,
                                    milligram: weightValue * 0.001,
                                    decigram: weightValue * 1e-8,
                                    centigram: weightValue * 1e-7,
                                    metricTon: weightValue * 1e-12,
                                    longTon: weightValue * 9.842065276e-13,
                                    shortTon: weightValue * 1.10231131e-12,
                                    pound: weightValue * 2.20462262e-9,
                                    ounce: weightValue * 3.52739619e-8,
                                    carat: weightValue * 5e-6,
                                    atomicMassUnit: weightValue * 6.022136651e+17,
                                    dalton: weightValue * 6.022173643e+17,
                                    gamma: weightValue,
                                    planckMass: weightValue * 45940.892448,
                                    electronMass: weightValue * 1.097768382e+23,
                                    muonMass: weightValue * 5.309172492e+20,
                                    protonMass: weightValue * 5.978633201e+19,
                                    neutronMass: weightValue * 5.970403753e+19,
                                    deuteronMass: weightValue * 2.990800894e+19,
                                    earthMass: weightValue * 1.673360107e-28,
                                    sunMass: weightValue * 5e-34
                                };
                                break;

                            case "planckMass":
                                result = {
                                    gram: weightValue * 2.176434e-8,
                                    kilogram: weightValue * 2.176434e-11,
                                    milligram: weightValue * 2.176434e-5,
                                    decigram: weightValue * 2.176434e-10,
                                    centigram: weightValue * 2.176434e-9,
                                    metricTon: weightValue * 2.176434e-14,
                                    longTon: weightValue * 2.13888e-14,
                                    shortTon: weightValue * 2.385057e-14,
                                    pound: weightValue * 4.742703e-11,
                                    ounce: weightValue * 7.588326e-10,
                                    carat: weightValue * 1.08825e-8,
                                    atomicMassUnit: weightValue * 6.60839e+28,
                                    dalton: weightValue * 6.609588846e+28,
                                    gamma: weightValue * 2.176434e+26,
                                    planckMass: weightValue,
                                    electronMass: weightValue * 2.330217446e+15,
                                    muonMass: weightValue * 1.12535103e+13,
                                    protonMass: weightValue * 1.26259493e+12,
                                    neutronMass: weightValue * 1.25992737e+12,
                                    deuteronMass: weightValue * 6.29716362e+12,
                                    earthMass: weightValue * 3.74294408e-49,
                                    sunMass: weightValue * 1.12371601e-52
                                };
                                break;
                            case "electronMass":
                                result = {
                                    gram: weightValue * 9.10938356e-28,
                                    kilogram: weightValue * 9.10938356e-31,
                                    milligram: weightValue * 9.10938356e-25,
                                    decigram: weightValue * 9.10938356e-30,
                                    centigram: weightValue * 9.10938356e-29,
                                    metricTon: weightValue * 9.10938356e-35,
                                    longTon: weightValue * 8.94724298e-35,
                                    shortTon: weightValue * 9.97259046e-35,
                                    pound: weightValue * 1.99839622e-31,
                                    ounce: weightValue * 3.19743395e-30,
                                    carat: weightValue * 4.60839678e-28,
                                    atomicMassUnit: weightValue * 2.742131e+25,
                                    dalton: weightValue * 2.74365117e+25,
                                    gamma: weightValue * 9.10938356e+22,
                                    planckMass: weightValue * 4.34276966e-42,
                                    electronMass: weightValue,
                                    muonMass: weightValue * 4.83633127e-11,
                                    protonMass: weightValue * 5.4386676e-10,
                                    neutronMass: weightValue * 5.42987629e-10,
                                    deuteronMass: weightValue * 2.71568588e-09,
                                    earthMass: weightValue * 1.61202657e-55,
                                    sunMass: weightValue * 4.8292667e-59
                                };
                                break;
                            case "muonMass":
                                result = {
                                    gram: weightValue * 1.883531594e-25,
                                    kilogram: weightValue * 1.883531594e-28,
                                    milligram: weightValue * 1.883531594e-22,
                                    decigram: weightValue * 1.883531594e-27,
                                    centigram: weightValue * 1.883531594e-26,
                                    metricTon: weightValue * 1.883531594e-32,
                                    longTon: weightValue * 1.849238198e-32,
                                    shortTon: weightValue * 2.059999202e-32,
                                    pound: weightValue * 4.097211065e-29,
                                    ounce: weightValue * 6.555537703e-28,
                                    carat: weightValue * 9.448013788e-26,
                                    atomicMassUnit: weightValue * 5.609588646e+26,
                                    dalton: weightValue * 5.610744008e+26,
                                    gamma: weightValue * 1.883531594e+24,
                                    planckMass: weightValue * 9.00869637e-41,
                                    electronMass: weightValue * 7.69274119e+10,
                                    muonMass: weightValue,
                                    protonMass: weightValue * 1.12136751e-8,
                                    neutronMass: weightValue * 1.11915568e-8,
                                    deuteronMass: weightValue * 5.60428694e-8,
                                    earthMass: weightValue * 3.33105586e-54,
                                    sunMass: weightValue * 1.00054445e-57
                                };
                                break;
                            case "protonMass":
                                result = {
                                    gram: weightValue * 1.6726219e-24,
                                    kilogram: weightValue * 1.6726219e-27,
                                    milligram: weightValue * 1.6726219e-21,
                                    decigram: weightValue * 1.6726219e-26,
                                    centigram: weightValue * 1.6726219e-25,
                                    metricTon: weightValue * 1.6726219e-31,
                                    longTon: weightValue * 1.6446144e-31,
                                    shortTon: weightValue * 1.830472e-31,
                                    pound: weightValue * 3.703891e-28,
                                    ounce: weightValue * 5.9262251e-27,
                                    carat: weightValue * 8.4947663e-25,
                                    atomicMassUnit: weightValue * 5.0088364e+26,
                                    dalton: weightValue * 5.0093099e+26,
                                    gamma: weightValue * 1.6726219e+24,
                                    planckMass: weightValue * 8.0115269e-41,
                                    electronMass: weightValue * 6.8671694e+9,
                                    muonMass: weightValue * 3.2369693e+7,
                                    protonMass: weightValue,
                                    neutronMass: weightValue * 0.9986234781,
                                    deuteronMass: weightValue * 0.0019947628,
                                    earthMass: weightValue * 1.1843135e-55,
                                    sunMass: weightValue * 3.5430469e-59
                                };
                                break;
                            case "neutronMass":
                                result = {
                                    gram: weightValue * 1.6749275e-24,
                                    kilogram: weightValue * 1.6749275e-27,
                                    milligram: weightValue * 1.6749275e-21,
                                    decigram: weightValue * 1.6749275e-26,
                                    centigram: weightValue * 1.6749275e-25,
                                    metricTon: weightValue * 1.6749275e-31,
                                    longTon: weightValue * 1.6468185e-31,
                                    shortTon: weightValue * 1.8338314e-31,
                                    pound: weightValue * 3.7042423e-28,
                                    ounce: weightValue * 5.9267878e-27,
                                    carat: weightValue * 8.5004294e-25,
                                    atomicMassUnit: weightValue * 5.0072666e+26,
                                    dalton: weightValue * 5.0077394e+26,
                                    gamma: weightValue * 1.6749275e+24,
                                    planckMass: weightValue * 8.0053053e-41,
                                    electronMass: weightValue * 6.8604505e+9,
                                    muonMass: weightValue * 3.2339436e+7,
                                    protonMass: weightValue * 0.9986234781,
                                    neutronMass: weightValue,
                                    deuteronMass: weightValue * 0.0020086649,
                                    earthMass: weightValue * 1.1855713e-55,
                                    sunMass: weightValue * 3.5468601e-59
                                };
                                break;
                            case "deuteronMass":
                                result = {
                                    gram: weightValue * 3.3435832e-24,
                                    kilogram: weightValue * 3.3435832e-27,
                                    milligram: weightValue * 3.3435832e-21,
                                    decigram: weightValue * 3.3435832e-26,
                                    centigram: weightValue * 3.3435832e-25,
                                    metricTon: weightValue * 3.3435832e-31,
                                    longTon: weightValue * 3.2873062e-31,
                                    shortTon: weightValue * 3.6576628e-31,
                                    pound: weightValue * 7.372998e-28,
                                    ounce: weightValue * 1.1796797e-26,
                                    carat: weightValue * 1.6953543e-24,
                                    atomicMassUnit: weightValue * 1.0033551e+27,
                                    dalton: weightValue * 1.0034015e+27,
                                    gamma: weightValue * 3.3435832e+24,
                                    planckMass: weightValue * 1.6025101e-40,
                                    electronMass: weightValue * 1.3709782e+10,
                                    muonMass: weightValue * 6.451153e+7,
                                    protonMass: weightValue * 1.8756136,
                                    neutronMass: weightValue * 1.8756129,
                                    deuteronMass: weightValue,
                                    earthMass: weightValue * 5.9473676e-55,
                                    sunMass: weightValue * 1.7788556e-58
                                };
                                break;
                            case "earthMass":
                                result = {
                                    gram: weightValue * 5.97219e+27,
                                    kilogram: weightValue * 5.97219e+24,
                                    milligram: weightValue * 5.97219e+30,
                                    decigram: weightValue * 5.97219e+25,
                                    centigram: weightValue * 5.97219e+26,
                                    metricTon: weightValue * 5.97219e+21,
                                    longTon: weightValue * 5.87561e+21,
                                    shortTon: weightValue * 6.53512e+21,
                                    pound: weightValue * 1.29059e+25,
                                    ounce: weightValue * 2.06542e+26,
                                    carat: weightValue * 2.97110e+27,
                                    atomicMassUnit: weightValue * 1.75767e+57,
                                    dalton: weightValue * 1.75844e+57,
                                    gamma: weightValue * 5.97219e+54,
                                    planckMass: weightValue * 2.85755e-14,
                                    electronMass: weightValue * 2.45172e+41,
                                    muonMass: weightValue * 1.15009e+39,
                                    protonMass: weightValue * 1.29163e+38,
                                    neutronMass: weightValue * 1.28998e+38,
                                    deuteronMass: weightValue * 6.45879e+38,
                                    earthMass: weightValue,
                                    sunMass: weightValue * 2.989e-6
                                };
                                break;

                            case "sunMass":
                                result = {
                                    gram: weightValue * 1.98847e+33,
                                    kilogram: weightValue * 1.98847e+30,
                                    milligram: weightValue * 1.98847e+36,
                                    decigram: weightValue * 1.98847e+31,
                                    centigram: weightValue * 1.98847e+32,
                                    metricTon: weightValue * 1.98847e+27,
                                    longTon: weightValue * 1.95756e+27,
                                    shortTon: weightValue * 2.1766e+27,
                                    pound: weightValue * 4.385e+30,
                                    ounce: weightValue * 7.016e+31,
                                    carat: weightValue * 1.007e+33,
                                    atomicMassUnit: weightValue * 5.959e+55,
                                    dalton: weightValue * 5.961e+55,
                                    gamma: weightValue * 1.98847e+52,
                                    planckMass: weightValue * 9.5479e-15,
                                    electronMass: weightValue * 8.2349e+41,
                                    muonMass: weightValue * 3.8525e+39,
                                    protonMass: weightValue * 4.3268e+38,
                                    neutronMass: weightValue * 4.319e+38,
                                    deuteronMass: weightValue * 2.1589e+39,
                                    earthMass: weightValue * 3.3474e-14,
                                    sunMass: weightValue
                                };
                                break;

                        }

                        // Display the result
                        document.getElementById("weightResult").innerHTML = "Result: " +
                            "Gram: " + formatResult(result.gram, notation, decimalPlaces) + " g<br>" +
                            "Kilogram: " + formatResult(result.kilogram, notation, decimalPlaces) + " kg<br>" +
                            "Milligram: " + formatResult(result.milligram, notation, decimalPlaces) + " mg<br>" +
                            "Decigram: " + formatResult(result.decigram, notation, decimalPlaces) + " dg<br>" +
                            "Centigram: " + formatResult(result.centigram, notation, decimalPlaces) + " cg<br>" +
                            "Metric Ton: " + formatResult(result.metricTon, notation, decimalPlaces) + " t<br>" +
                            "Long Ton: " + formatResult(result.longTon, notation, decimalPlaces) + "<br>" +
                            "Short Ton: " + formatResult(result.shortTon, notation, decimalPlaces) + "<br>" +
                            "Pound: " + formatResult(result.pound, notation, decimalPlaces) + " lbs<br>" +
                            "Ounce: " + formatResult(result.ounce, notation, decimalPlaces) + " oz<br>" +
                            "Carat: " + formatResult(result.carat, notation, decimalPlaces) + " ct<br>" +
                            "Atomic Mass Unit: " + formatResult(result.atomicMassUnit, notation, decimalPlaces) + " u<br>" +
                            "Dalton: " + formatResult(result.dalton, notation, decimalPlaces) + " Da<br>" +
                            "Gamma: " + formatResult(result.gamma, notation, decimalPlaces) + " &#120574;<br>" +
                            "Planck Mass: " + formatResult(result.planckMass, notation, decimalPlaces) + "<br>" +
                            "Electron Mass: " + formatResult(result.electronMass, notation, decimalPlaces) + "<br>" +
                            "Muon Mass: " + formatResult(result.muonMass, notation, decimalPlaces) + "<br>" +
                            "Proton Mass: " + formatResult(result.protonMass, notation, decimalPlaces) + "<br>" +
                            "Neutron Mass: " + formatResult(result.neutronMass, notation, decimalPlaces) + "<br>" +
                            "Deuteron Mass: " + formatResult(result.deuteronMass, notation, decimalPlaces) + "<br>" +
                            "Earth Mass: " + formatResult(result.earthMass, notation, decimalPlaces) + "<br>" +
                            "Sun Mass: " + formatResult(result.sunMass, notation, decimalPlaces);
                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                    break;
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                    break;
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                                    break;
                            }
                        }

                    }

                    function convertLength() {
                        // Get user input
                        var lengthValue = parseFloat(document.getElementById("lengthValue").value);
                        var lengthUnit = document.getElementById("lengthUnit").value;
                        var notation = document.getElementById("lengthNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("lengthDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (lengthUnit) {
                            case "meter":
                                result = {
                                    meter: lengthValue,
                                    kilometer: lengthValue / 1000,
                                    decimeter: lengthValue * 10,
                                    centimeter: lengthValue * 100,
                                    millimeter: lengthValue * 1000,
                                    micrometer: lengthValue * 1000000,
                                    nanometer: lengthValue * 1000000000,
                                    mile: lengthValue * 0.0006213712,
                                    yard: lengthValue * 1.0936132983,
                                    foot: lengthValue * 3.280839895,
                                    inch: lengthValue * 39.37007874,
                                    planckLength: lengthValue * 6.187927353E+34,
                                    electronRadius: lengthValue * 354869043883290,
                                    bohradius: lengthValue * 18897259886,
                                    earthEquatorialRadius: lengthValue * 1.567850289E-7,
                                    earthEPolarRadius: lengthValue * 1.573124242E-7,
                                    earthDistanceFromSun: lengthValue * 6.684491978E-12,
                                    sunRadius: lengthValue * 1.436781609E-9
                                };
                                break;
                            case "kilometer":
                                result = {
                                    meter: lengthValue * 1000,
                                    kilometer: lengthValue,
                                    decimeter: lengthValue * 10000,
                                    centimeter: lengthValue * 100000,
                                    millimeter: lengthValue * 1000000,
                                    micrometer: lengthValue * 1000000000,
                                    nanometer: lengthValue * 1000000000000,
                                    mile: lengthValue * 0.6213711922,
                                    yard: lengthValue * 1093.6132983,
                                    foot: lengthValue * 3280.839895,
                                    inch: lengthValue * 39370.07874,
                                    planckLength: lengthValue * 6.187927353E+37,
                                    electronRadius: lengthValue * 354869043883290000,
                                    bohradius: lengthValue * 18897259885789,
                                    earthEquatorialRadius: lengthValue * 0.000156785,
                                    earthEPolarRadius: lengthValue * 0.0001573124,
                                    earthDistanceFromSun: lengthValue * 6.684491978E-9,
                                    sunRadius: lengthValue * 0.0000014368
                                };
                                break; AZ

                            case "decimeter":
                                result = {
                                    meter: lengthValue / 10,
                                    kilometer: lengthValue / 10000,
                                    decimeter: lengthValue,
                                    centimeter: lengthValue * 10,
                                    millimeter: lengthValue * 100,
                                    micrometer: lengthValue * 100000,
                                    nanometer: lengthValue * 100000000,
                                    mile: lengthValue * 0.0000621371,
                                    yard: lengthValue * 0.10936132983,
                                    foot: lengthValue * 0.3280839895,
                                    inch: lengthValue * 3.937007874,
                                    planckLength: lengthValue * 6.187927353E+33,
                                    electronRadius: lengthValue * 35486904388329,
                                    bohradius: lengthValue * 1889725988.6,
                                    earthEquatorialRadius: lengthValue * 1.567850289E-8,
                                    earthEPolarRadius: lengthValue * 1.573124242E-8,
                                    earthDistanceFromSun: lengthValue * 6.684491978E-13,
                                    sunRadius: lengthValue * 1.436781609E-10
                                };
                                break;
                            case "centimeter":  //till
                                result = {
                                    meter: lengthValue / 100,
                                    kilometer: lengthValue / 100000,
                                    decimeter: lengthValue / 10,
                                    centimeter: lengthValue,
                                    millimeter: lengthValue * 10,
                                    micrometer: lengthValue * 10000,
                                    nanometer: lengthValue * 10000000,
                                    mile: lengthValue * 6.213711922e-6,
                                    yard: lengthValue * 0.010936132983,
                                    foot: lengthValue * 0.03280839895,
                                    inch: lengthValue * 0.3937007874,
                                    planckLength: lengthValue * 6.187927353e31,
                                    electronRadius: lengthValue * 3.5486904388329e12,
                                    bohradius: lengthValue * 1.8897259886e8,
                                    earthEquatorialRadius: lengthValue * 1.567850289e-5,
                                    earthEPolarRadius: lengthValue * 1.573124242e-5,
                                    earthDistanceFromSun: lengthValue * 6.684491978e-10,
                                    sunRadius: lengthValue * 1.436781609e-7
                                };
                                break;

                            case "millimeter":
                                result = {
                                    meter: lengthValue / 1000,
                                    kilometer: lengthValue / 1e6,
                                    decimeter: lengthValue / 100,
                                    centimeter: lengthValue / 10,
                                    millimeter: lengthValue,
                                    micrometer: lengthValue * 1000,
                                    nanometer: lengthValue * 1e6,
                                    mile: lengthValue * 6.213711922e-10,
                                    yard: lengthValue * 0.0010936132983,
                                    foot: lengthValue * 0.003280839895,
                                    inch: lengthValue * 0.03937007874,
                                    planckLength: lengthValue * 6.187927353e27,
                                    electronRadius: lengthValue * 3.5486904388329e8,
                                    bohradius: lengthValue * 1.8897259886e4,
                                    earthEquatorialRadius: lengthValue * 1.567850289e-7,
                                    earthEPolarRadius: lengthValue * 1.573124242e-7,
                                    earthDistanceFromSun: lengthValue * 6.684491978e-12,
                                    sunRadius: lengthValue * 1.436781609e-9
                                };
                                break;

                            case "micrometer":
                                result = {
                                    meter: lengthValue / 1e6,
                                    kilometer: lengthValue / 1e9,
                                    decimeter: lengthValue / 1e5,
                                    centimeter: lengthValue / 1e4,
                                    millimeter: lengthValue / 1000,
                                    micrometer: lengthValue,
                                    nanometer: lengthValue * 1000,
                                    mile: lengthValue * 6.213711922e-13,
                                    yard: lengthValue * 1.0936132983e-6,
                                    foot: lengthValue * 3.280839895e-6,
                                    inch: lengthValue * 3.937007874e-5,
                                    planckLength: lengthValue * 6.187927353e24,
                                    electronRadius: lengthValue * 3.5486904388329e5,
                                    bohradius: lengthValue * 1.8897259886e1,
                                    earthEquatorialRadius: lengthValue * 1.567850289e-12,
                                    earthEPolarRadius: lengthValue * 1.573124242e-12,
                                    earthDistanceFromSun: lengthValue * 6.684491978e-17,
                                    sunRadius: lengthValue * 1.436781609e-14
                                };
                                break;

                            case "nanometer":
                                result = {
                                    meter: lengthValue / 1e9,
                                    kilometer: lengthValue / 1e12,
                                    decimeter: lengthValue / 1e8,
                                    centimeter: lengthValue / 1e7,
                                    millimeter: lengthValue / 1e6,
                                    micrometer: lengthValue / 1000,
                                    nanometer: lengthValue,
                                    mile: lengthValue * 6.213711922e-16,
                                    yard: lengthValue * 1.0936132983e-9,
                                    foot: lengthValue * 3.280839895e-9,
                                    inch: lengthValue * 3.937007874e-8,
                                    planckLength: lengthValue * 6.187927353e21,
                                    electronRadius: lengthValue * 3.5486904388329,
                                    bohradius: lengthValue * 1.8897259886e-2,
                                    earthEquatorialRadius: lengthValue * 1.567850289e-15,
                                    earthEPolarRadius: lengthValue * 1.573124242e-15,
                                    earthDistanceFromSun: lengthValue * 6.684491978e-20,
                                    sunRadius: lengthValue * 1.436781609e-17
                                };
                                break;

                            case "mile":
                                result = {
                                    meter: lengthValue / 0.0006213712,
                                    kilometer: lengthValue / 0.6213712,
                                    decimeter: lengthValue * 16093.44,
                                    centimeter: lengthValue * 160934.4,
                                    millimeter: lengthValue * 1609344,
                                    micrometer: lengthValue * 1.609344e9,
                                    nanometer: lengthValue * 1.609344e12,
                                    mile: lengthValue,
                                    yard: lengthValue * 1760,
                                    foot: lengthValue * 5280,
                                    inch: lengthValue * 63360,
                                    planckLength: lengthValue * 3.937007874e33,
                                    electronRadius: lengthValue * 2.2369362920544e16,
                                    bohradius: lengthValue * 1.1886679997e12,
                                    earthEquatorialRadius: lengthValue * 3.9535993e-4,
                                    earthEPolarRadius: lengthValue * 3.963343004e-4,
                                    earthDistanceFromSun: lengthValue * 1.687393673e-8,
                                    sunRadius: lengthValue * 3.634543835e-6
                                };
                                break;

                            case "yard":
                                result = {
                                    meter: lengthValue / 1.0936132983,
                                    kilometer: lengthValue / 1093.6132983,
                                    decimeter: lengthValue * 9.144,
                                    centimeter: lengthValue * 91.44,
                                    millimeter: lengthValue * 914.4,
                                    micrometer: lengthValue * 914400,
                                    nanometer: lengthValue * 9.144e8,
                                    mile: lengthValue * 1.760000e-3,
                                    yard: lengthValue,
                                    foot: lengthValue * 3,
                                    inch: lengthValue * 36,
                                    planckLength: lengthValue * 2.244666007e32,
                                    electronRadius: lengthValue * 1.28836488247e15,
                                    bohradius: lengthValue * 6.8358942879e10,
                                    earthEquatorialRadius: lengthValue * 2.267573696e-4,
                                    earthEPolarRadius: lengthValue * 2.2737371315e-4,
                                    earthDistanceFromSun: lengthValue * 9.69849313e-9,
                                    sunRadius: lengthValue * 2.092850947e-6
                                };
                                break;

                            case "foot":
                                result = {
                                    meter: lengthValue / 3.280839895,
                                    kilometer: lengthValue / 3280.839895,
                                    decimeter: lengthValue * 3.048,
                                    centimeter: lengthValue * 30.48,
                                    millimeter: lengthValue * 304.8,
                                    micrometer: lengthValue * 304800,
                                    nanometer: lengthValue * 3.048e8,
                                    mile: lengthValue * 0.0001893939,
                                    yard: lengthValue / 3,
                                    foot: lengthValue,
                                    inch: lengthValue * 12,
                                    planckLength: lengthValue * 1.893988352E+34,
                                    electronRadius: lengthValue * 1.090952864E+15,
                                    bohradius: lengthValue * 5.799127031E+10,
                                    earthEquatorialRadius: lengthValue * 2.004684214E-4,
                                    earthEPolarRadius: lengthValue * 2.011694101E-4,
                                    earthDistanceFromSun: lengthValue * 8.574362839E-9,
                                    sunRadius: lengthValue * 1.850989549E-6
                                };
                                break;

                            case "inch":
                                result = {
                                    meter: lengthValue / 39.37007874,
                                    kilometer: lengthValue / 39370.07874,
                                    decimeter: lengthValue * 2.54,
                                    centimeter: lengthValue * 25.4,
                                    millimeter: lengthValue * 254,
                                    micrometer: lengthValue * 25400,
                                    nanometer: lengthValue * 2.54e7,
                                    mile: lengthValue * 1.578282828e-5,
                                    yard: lengthValue / 36,
                                    foot: lengthValue / 12,
                                    inch: lengthValue,
                                    planckLength: lengthValue * 1.57480315e33,
                                    electronRadius: lengthValue * 9.09060732e14,
                                    bohradius: lengthValue * 4.832605859e10,
                                    earthEquatorialRadius: lengthValue * 1.670570178e-5,
                                    earthEPolarRadius: lengthValue * 1.676411751e-5,
                                    earthDistanceFromSun: lengthValue * 7.145302366e-10,
                                    sunRadius: lengthValue * 1.541824624e-7
                                };
                                break;

                            case "planckLength":
                                result = {
                                    meter: lengthValue / 6.187927353e34,
                                    kilometer: lengthValue / 6.187927353e37,
                                    decimeter: lengthValue * 1.016005845e-34,
                                    centimeter: lengthValue * 1.016005845e-33,
                                    millimeter: lengthValue * 1.016005845e-32,
                                    micrometer: lengthValue * 1.016005845e-26,
                                    nanometer: lengthValue * 1.016005845e-23,
                                    mile: lengthValue * 6.196176527e-38,
                                    yard: lengthValue * 1.057545192e-34,
                                    foot: lengthValue * 3.280839895e-34,
                                    inch: lengthValue * 3.937007874e-33,
                                    planckLength: lengthValue,
                                    electronRadius: lengthValue * 5.76861612e18,
                                    bohradius: lengthValue * 3.071804995e27,
                                    earthEquatorialRadius: lengthValue * 1.272621778e-63,
                                    earthEPolarRadius: lengthValue * 1.276277631e-63,
                                    earthDistanceFromSun: lengthValue * 5.444669314e-68,
                                    sunRadius: lengthValue * 1.173777514e-65
                                };
                                break;

                            case "electronRadius":
                                result = {
                                    meter: lengthValue / 354869043883290,
                                    kilometer: lengthValue / 3.5486904388329e14,
                                    decimeter: lengthValue * 2.819597556e-15,
                                    centimeter: lengthValue * 2.819597556e-14,
                                    millimeter: lengthValue * 2.819597556e-13,
                                    micrometer: lengthValue * 2.819597556e-7,
                                    nanometer: lengthValue * 0.2819597556,
                                    mile: lengthValue * 1.746895221e-16,
                                    yard: lengthValue * 2.988074983e-15,
                                    foot: lengthValue * 9.144837777e-15,
                                    inch: lengthValue * 1.097380533e-13,
                                    planckLength: lengthValue * 1.735878472e13,
                                    electronRadius: lengthValue,
                                    bohradius: lengthValue * 5.312104639e7,
                                    earthEquatorialRadius: lengthValue * 2.206280927e-22,
                                    earthEPolarRadius: lengthValue * 2.215232613e-22,
                                    earthDistanceFromSun: lengthValue * 9.432396662e-27,
                                    sunRadius: lengthValue * 2.034672063e-24
                                };
                                break;

                            case "bohradius":
                                result = {
                                    meter: lengthValue / 18897259886,
                                    kilometer: lengthValue / 1.8897259886e10,
                                    decimeter: lengthValue * 5.291772108e-12,
                                    centimeter: lengthValue * 5.291772108e-11,
                                    millimeter: lengthValue * 5.291772108e-10,
                                    micrometer: lengthValue * 5.291772108e-4,
                                    nanometer: lengthValue * 0.5291772108,
                                    mile: lengthValue * 3.280839895e-12,
                                    yard: lengthValue * 5.612323001e-11,
                                    foot: lengthValue * 1.7150148106e-10,
                                    inch: lengthValue * 2.0580177727e-9,
                                    planckLength: lengthValue * 3.2463393153e10,
                                    electronRadius: lengthValue * 1.877702383e-18,
                                    bohradius: lengthValue,
                                    earthEquatorialRadius: lengthValue * 4.136360852e-23,
                                    earthEPolarRadius: lengthValue * 4.152692562e-23,
                                    earthDistanceFromSun: lengthValue * 1.771869010e-27,
                                    sunRadius: lengthValue * 3.822312823e-25
                                };
                                break;

                            case "earthEquatorialRadius":
                                result = {
                                    meter: lengthValue / 1.567850289e-7,
                                    kilometer: lengthValue / 156785.0289,
                                    decimeter: lengthValue * 1.018591635e7,
                                    centimeter: lengthValue * 1.018591635e8,
                                    millimeter: lengthValue * 1.018591635e9,
                                    micrometer: lengthValue * 1.018591635e13,
                                    nanometer: lengthValue * 1.018591635e16,
                                    mile: lengthValue * 6.684587122e-8,
                                    yard: lengthValue * 1.0936132983e-4,
                                    foot: lengthValue * 3.280839895e-4,
                                    inch: lengthValue * 0.003937007874,
                                    planckLength: lengthValue * 6.211801117e41,
                                    electronRadius: lengthValue * 3.578869036e24,
                                    bohradius: lengthValue * 1.894845152e18,
                                    earthEquatorialRadius: lengthValue,
                                    earthEPolarRadius: lengthValue * 1.005074422,
                                    earthDistanceFromSun: lengthValue * 4.265928009e-11,
                                    sunRadius: lengthValue * 9.194620782e-9
                                };
                                break;

                            case "earthEPolarRadius":
                                result = {
                                    meter: lengthValue / 1.573124242e-7,
                                    kilometer: lengthValue / 157312.4242,
                                    decimeter: lengthValue * 1.023529412e7,
                                    centimeter: lengthValue * 1.023529412e8,
                                    millimeter: lengthValue * 1.023529412e9,
                                    micrometer: lengthValue * 1.023529412e13,
                                    nanometer: lengthValue * 1.023529412e16,
                                    mile: lengthValue * 6.722307277e-8,
                                    yard: lengthValue * 1.0979796897e-4,
                                    foot: lengthValue * 3.293939069e-4,
                                    inch: lengthValue * 0.003952726882,
                                    planckLength: lengthValue * 6.237510404e41,
                                    electronRadius: lengthValue * 3.600769133e24,
                                    bohradius: lengthValue * 1.910863652e18,
                                    earthEquatorialRadius: lengthValue * 0.9949688665,
                                    earthEPolarRadius: lengthValue,
                                    earthDistanceFromSun: lengthValue * 4.267639077e-11,
                                    sunRadius: lengthValue * 9.232520466e-9
                                };
                                break;
                            case "earthDistanceFromSun":
                                result = {
                                    meter: lengthValue / 6.684491978e-12,
                                    kilometer: lengthValue / 6684.491978,
                                    decimeter: lengthValue * 1.092736372e11,
                                    centimeter: lengthValue * 1.092736372e12,
                                    millimeter: lengthValue * 1.092736372e13,
                                    micrometer: lengthValue * 1.092736372e17,
                                    nanometer: lengthValue * 1.092736372e20,
                                    mile: lengthValue * 7.215225857e-9,
                                    yard: lengthValue * 1.177114107e-5,
                                    foot: lengthValue * 3.531342321e-5,
                                    inch: lengthValue * 0.0004237609181,
                                    planckLength: lengthValue * 6.705218534e34,
                                    electronRadius: lengthValue * 3.870533684e27,
                                    bohradius: lengthValue * 2.048092461e22,
                                    earthEquatorialRadius: lengthValue * 2.340748637e-11,
                                    earthEPolarRadius: lengthValue * 2.350796707e-11,
                                    earthDistanceFromSun: lengthValue,
                                    sunRadius: lengthValue * 2.162077507e-8
                                };
                                break;

                            case "sunRadius":
                                result = {
                                    meter: lengthValue / 1.436781609e-9,
                                    kilometer: lengthValue / 1436781.609,
                                    decimeter: lengthValue * 9.297458612e10,
                                    centimeter: lengthValue * 9.297458612e11,
                                    millimeter: lengthValue * 9.297458612e12,
                                    micrometer: lengthValue * 9.297458612e16,
                                    nanometer: lengthValue * 9.297458612e19,
                                    mile: lengthValue * 6.112408289e-7,
                                    yard: lengthValue * 1006.264049,
                                    foot: lengthValue * 3018.792148,
                                    inch: lengthValue * 36225.50577,
                                    planckLength: lengthValue * 6.724070512e34,
                                    electronRadius: lengthValue * 3.881781181e27,
                                    bohradius: lengthValue * 2.049848649e22,
                                    earthEquatorialRadius: lengthValue * 2.346485866e-11,
                                    earthEPolarRadius: lengthValue * 2.356633993e-11,
                                    earthDistanceFromSun: lengthValue * 4.289110123e-8,
                                    sunRadius: lengthValue
                                };
                                break;
                        }

                        // Display the result
                        document.getElementById("lengthResult").innerHTML = "Result: " +
                            "Meter: " + formatResult(result.meter, notation, decimalPlaces) + " m<br>" +
                            "Kilometer: " + formatResult(result.kilometer, notation, decimalPlaces) + " km<br>" +
                            "Decimeter: " + formatResult(result.decimeter, notation, decimalPlaces) + " dm<br>" +
                            "Centimeter: " + formatResult(result.centimeter, notation, decimalPlaces) + " cm<br>" +
                            "Millimeter: " + formatResult(result.millimeter, notation, decimalPlaces) + " mm<br>" +
                            "Micrometer: " + formatResult(result.micrometer, notation, decimalPlaces) + " µm<br>" +
                            "Nanometer: " + formatResult(result.nanometer, notation, decimalPlaces) + " nm<br>" +
                            "Mile: " + formatResult(result.mile, notation, decimalPlaces) + " mi<br>" +
                            "Yard: " + formatResult(result.yard, notation, decimalPlaces) + " yd<br>" +
                            "Foot: " + formatResult(result.foot, notation, decimalPlaces) + " ft<br>" +
                            "Inch: " + formatResult(result.inch, notation, decimalPlaces) + " in<br>" +
                            "Planck Length: " + formatResult(result.planckLength, notation, decimalPlaces) + "<br>" +
                            "Electron Radius: " + formatResult(result.electronRadius, notation, decimalPlaces) + "<br>" +
                            "Bohradius: " + formatResult(result.bohradius, notation, decimalPlaces) + "<br>" +
                            "Earth Equatorial Radius: " + formatResult(result.earthEquatorialRadius, notation, decimalPlaces) + " <br>" +
                            "Earth Polar Radius: " + formatResult(result.earthPolarRadius, notation, decimalPlaces) + " <br>" +
                            "Earth Distance From Sun: " + formatResult(result.earthDistanceFromSun, notation, decimalPlaces) + " <br>" +
                            "Sun Radius: " + formatResult(result.sunRadius, notation, decimalPlaces);

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                    break;
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                    break;
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                                    break;
                            }
                        }

                    }

                    function convertTime() {
                        // Get user input
                        var timeValue = parseFloat(document.getElementById("timeValue").value);
                        var timeUnit = document.getElementById("timeUnit").value;
                        var notation = document.getElementById("timeNotation").value;
                        var decimalPlaces = parseInt(document.getElementById("timeDecimalPlaces").value);

                        // Perform the conversion
                        var result;
                        switch (timeUnit) {
                            case "second":
                                result = {
                                    second: timeValue,
                                    millisecond: timeValue * 1000,
                                    minute: timeValue / 60,
                                    hour: timeValue / 3600,
                                    day: timeValue / 86400,
                                    week: timeValue / 604800,
                                    month: timeValue * 3.805175038E-7,
                                    year: timeValue * 3.1688087814029E-8,
                                    decade: timeValue * 3.168808781E-9,
                                    century: timeValue * 3.168808781E-10,
                                };
                                break;
                            case "millisecond":
                                result = {
                                    millisecond: timeValue,
                                    second: timeValue / 1000,
                                    minute: timeValue / 60000,
                                    hour: timeValue * 2.777777777E-7,
                                    day: timeValue * 1.157407407E-8,
                                    week: timeValue * 1.653439153E-9,
                                    month: timeValue * 3.805175038E-10,
                                    year: timeValue * 3.168808781E-11,
                                    decade: timeValue * 3.168808781E-12,
                                    century: timeValue * 3.168808781E-13,
                                };
                                break;
                            case "minute":
                                result = {
                                    minute: timeValue,
                                    millisecond: timeValue * 60000,
                                    second: timeValue * 60,
                                    hour: timeValue * 0.0166666667,
                                    day: timeValue * 0.0006944444,
                                    week: timeValue * 0.0000992063,
                                    month: timeValue * 0.0000228311,
                                    year: timeValue * 0.0000019013,
                                    decade: timeValue * 1.901285268E-7,
                                    century: timeValue * 1.901285268E-8,
                                };
                                break;
                            case "hour":
                                result = {
                                    hour: timeValue,
                                    millisecond: timeValue * 3600000,
                                    second: timeValue * 3600,
                                    minute: timeValue * 60,
                                    day: timeValue * 0.0416666667,
                                    week: timeValue * 0.005952381,
                                    month: timeValue * 0.001369863,
                                    year: timeValue * 0.0001140771,
                                    decade: timeValue * 0.0000114077,
                                    century: timeValue * 0.0000011408,
                                };
                                break;

                            case "day":
                                result = {
                                    day: timeValue,
                                    millisecond: timeValue * 86400000,
                                    second: timeValue * 86400,
                                    minute: timeValue * 1440,
                                    hour: timeValue * 24,
                                    week: timeValue * 0.1428571429,
                                    month: timeValue * 0.0328767123,
                                    year: timeValue * 0.0027378508,
                                    decade: timeValue * 0.0002737851,
                                    century: timeValue * 0.0000273785,
                                };
                                break;

                            case "week":
                                result = {
                                    week: timeValue,
                                    millisecond: timeValue * 604800000,
                                    second: timeValue * 604800,
                                    minute: timeValue * 10080,
                                    hour: timeValue * 168,
                                    day: timeValue * 7,
                                    month: timeValue * 0.2301369863,
                                    year: timeValue * 0.0191649555,
                                    decade: timeValue * 0.0019164956,
                                    century: timeValue * 0.0001916496,
                                };
                                break;

                            case "month":
                                result = {
                                    month: timeValue,
                                    millisecond: timeValue * 2628000000,
                                    second: timeValue * 2628000,
                                    minute: timeValue * 43800,
                                    hour: timeValue * 730,
                                    day: timeValue * 30.416666667,
                                    week: timeValue * 4.3452380952,
                                    year: timeValue * 0.0832762948,
                                    decade: timeValue * 0.0083276295,
                                    century: timeValue * 0.0008327629,
                                };
                                break;

                            case "year":
                                result = {
                                    year: timeValue,
                                    millisecond: timeValue * 31557600000,
                                    second: timeValue * 31557600,
                                    minute: timeValue * 525960,
                                    hour: timeValue * 8766,
                                    day: timeValue * 365.25,
                                    week: timeValue * 52.178571429,
                                    month: timeValue * 12.008219178,
                                    decade: timeValue * 0.1,
                                    century: timeValue * 0.01,
                                };
                                break;

                            case "decade":
                                result = {
                                    decade: timeValue,
                                    millisecond: timeValue * 315576000000,
                                    second: timeValue * 315576000,
                                    minute: timeValue * 5259600,
                                    hour: timeValue * 87660,
                                    day: timeValue * 3652.5,
                                    week: timeValue * 521.78571429,
                                    month: timeValue * 120.08219178,
                                    year: timeValue * 10,
                                    century: timeValue * 0.1,
                                };
                                break;

                            case "century":
                                result = {
                                    century: timeValue,
                                    millisecond: timeValue * 3155760000000,
                                    second: timeValue * 3155760000,
                                    minute: timeValue * 52596000,
                                    hour: timeValue * 876600,
                                    day: timeValue * 36525,
                                    week: timeValue * 5217.8571429,
                                    month: timeValue * 1200.8219178,
                                    year: timeValue * 100,
                                    decade: timeValue * 10,
                                };
                                break;


                        }

                        // Display the result using the specified notation and decimal places
                        document.getElementById("timeResult").innerHTML = "Result: " +
                            "Millisecond: " + formatResult(result.millisecond, notation, decimalPlaces) + " ms<br>" +
                            "Second: " + formatResult(result.second, notation, decimalPlaces) + " s<br>" +
                            "Minute: " + formatResult(result.minute, notation, decimalPlaces) + " min<br>" +
                            "Hour: " + formatResult(result.hour, notation, decimalPlaces) + " h<br>" +
                            "Day: " + formatResult(result.day, notation, decimalPlaces) + " d<br>" +
                            "Week: " + formatResult(result.week, notation, decimalPlaces) + " <br>" +
                            "Month: " + formatResult(result.month, notation, decimalPlaces) + " <br>" +
                            "Year: " + formatResult(result.year, notation, decimalPlaces) + " y<br>" +
                            "Decade: " + formatResult(result.decade, notation, decimalPlaces) + "<br>" +
                            "Century: " + formatResult(result.century, notation, decimalPlaces);

                        function formatResult(value, notation, decimalPlaces) {
                            // Check if the value is very close to zero
                            switch (notation) {
                                case 'exponential':
                                    return value.toExponential(decimalPlaces);
                                    break;
                                case 'normal':
                                    return parseFloat(value.toFixed(decimalPlaces)).toPrecision(decimalPlaces);
                                    break;
                                case 'ndefault':
                                    if (Math.abs(value) <= 0.0000001) {
                                        return value.toExponential(decimalPlaces);
                                    } else {
                                        // Display without unnecessary trailing zeros
                                        return parseFloat(value.toFixed(decimalPlaces));
                                    }
                                    break;
                            }
                        }
                    }
                </script>
    </table>
</asp:Content>
