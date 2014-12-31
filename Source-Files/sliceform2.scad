zs = 25;

xs = 25;

ys = 25;

slicethick = .20;
slicespace = 3;
zslice = (zs*2)/slicespace;
yslice = (ys*2)/slicespace;

module sphereform()
{
	sphere(r = 25, $fn=50);
}

module cubeform()
{
	rotate(a = [45,45,45])
		cube(size = [28.86,28.86,28.86], center = true);
}

module form()
{
	sphereform();
}

module yslots()
{
	for (nz = [0:zslice])
	{
		translate(v = [xs/2,0,nz*slicespace - zs + slicespace/2])
		{
			cube(size = [xs,ys*2,slicethick], center = true);
		}
	}
}

module zslots()
{
	for (ny = [0:yslice])
	{
		translate(v = [-xs/2,ny*slicespace - ys + slicespace/2,0])
		{
			cube(size = [xs,slicethick,zs*2], center = true);
		}
	}
}

module ysliceform()
{
	rotate(a=[90,0,0])
		difference()
		{
			form();
	
			yslots();
		}
}

module zsliceform()
{
	
	difference()
	{
		form();

		zslots();
	}
}

module slices()
{
	for (nz = [0:zslice])
	{
		
		
		translate(v = [nz*xs*2.1,0,0])
		{
			projection(cut = true)
			{
				translate(v = [0,0,nz*slicespace - zs + slicespace/2])
				{ 
					zsliceform();
				}
			}
		}
	}
	
	
	for (ny = [0:yslice])
	{
		translate(v = [ny*xs*2.1,2.1*ys,0])
		{
			projection(cut = true)
			{
				translate(v = [0,0,ny*slicespace - ys + slicespace/2])
				{
					ysliceform();
				}
			}
		}
	}
}

//show form and cut box
//form();
//%yslots();
//%zslots();

//show form and cuts
//zsliceform();
//translate(v = [xs*2.1]) ysliceform();

//make slices			
slices();

