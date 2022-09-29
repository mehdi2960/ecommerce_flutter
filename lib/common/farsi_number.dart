String replaceFarsiNumber(String input)
{
    const english=['1','2','3','4','5'];
   	const farsi=['۱','۲','۳','۴','۵'];
	
	for(int i=0; i<english.length;i++)
	{
	   input=input.replaceAll(english[i],farsi[i]);
	}
	return input;
}
