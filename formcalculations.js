//plantTree() finds the plant tree price based on a check box selection
function planttreesPrice()
{
    var planttreePrice=0;
    //Get a reference to the form id="txttree"
    var theForm = document.forms["createproject"];
    //Get a reference to the checkbox id="txttree"
    var txtTree = theForm.elements["txttree"];
 
    //If they checked the box set treePrice to 7
    if(txtTree.checked==true)
    {
        planttreePrice=7.00;
    }

    //finally we return the treePrice
    return planttreePrice;
}

function solarpannelsPrice()
{
	var solarpannelPrice=0;

	var theForm = document.forms["createproject"];
	var txtSolar = theForm.elements["txtsolar"];

	if(txtSolar.checked==true)
	{
		solarpannelPrice=70.00;
	}
	return solarpannelPrice
}

function waterfiltersPrice()
{
	var waterfilterPrice=0;

	var theForm = document.forms["createproject"];
	var txtWater = theForm.elements["txtwater"];

	if(txtWater.checked==true)
	{
		waterfilterPrice=75.00;
	}
	return waterfilterPrice
}

function goatsPrice()
{
	var goatPrice=0;

	var theForm = document.forms["createproject"];
	var txtGoats = theForm.elements["txtgoats"];

	if(txtGoats.checked==true)
	{
		goatPrice=125.00;
	}
	return goatPrice
}

function kidsclubPrice()
{
	var kidclubPrice=0;

	var theForm = document.forms["createproject"];
	var txtKids = theForm.elements["txtkids"];

	if(txtKids.checked==true)
	{
		kidclubPrice=220.00;
	}
	return kidclubPrice
}

function houserestorationsPrice()
{
	var houserestorationPrice=0;

	var theForm = document.forms["createproject"];
	var txtHouse = theForm.elements["txthouse"];

	if(txtHouse.checked==true)
	{
		houserestorationPrice=240.00;
	}
	return houserestorationPrice
}

function roofrepairsPrice()
{
	var roofrepairPrice=0;

	var theForm = document.forms["createproject"];
	var txtRoof = theForm.elements["txtroof"];

	if(txtRoof.checked==true)
	{
		roofrepairPrice=450.00;
	}
	return roofrepairPrice
}

function latrinesPrice()
{
	var latrinePrice=0;

	var theForm = document.forms["createproject"];
	var txtLatrine = theForm.elements["txtlatrine"];

	if(txtLatrine.checked==true)
	{
		latrinePrice=1500.00;
	}
	return latrinePrice
}

function buildhomesPrice()
{
	var buildhomePrice=0;

	var theForm = document.forms["createproject"];
	var txtBuild = theForm.elements["txtbuild"];

	if(txtBuild.checked==true)
	{
		buildhomePrice=6600.00;
	}
	return buildhomePrice
}


function calculateTotal()
{
    //Here we get the total price by calling our function
    //Each function returns a number so by calling them we add the values they return together
    var projectPrice = planttreesPrice() + solarpannelsPrice() + waterfiltersPrice() + goatsPrice() + kidsclubPrice() + houserestorationsPrice() + roofrepairsPrice() + latrinesPrice() + buildhomesPrice();
 
    //display the result
    document.getElementById('totalPrice').innerHTML =
                                      "Total Price For Project $"+projectPrice;
 
}
