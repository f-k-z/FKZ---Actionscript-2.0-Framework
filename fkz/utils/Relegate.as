/**
 * @author Frédéric Saunier | open-sourcing@tekool.net | http://www.tekool.net/
 */

class fkz.utils.Relegate extends Object
{
	static function create(t:Object,f:Function):Function
	{
		var a:Array = arguments.splice(2);
		return function()
		{
			return f.apply
			(
				t,
				arguments.concat(a)
			);
		};
	}
}