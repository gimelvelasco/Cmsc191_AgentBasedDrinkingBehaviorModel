function [s_ret,d_ret,r_ret,t_ret] = getAllSDR(lattice,num_sites)
	s_ret = 0;
	d_ret = 0;
	r_ret = 0;

	for addrs=1:num_sites
		s_ret = s_ret + lattice(addrs,1);
		d_ret = d_ret + lattice(addrs,2);
		r_ret = r_ret + lattice(addrs,3);
	end
	t_ret = s_ret + d_ret + r_ret;
end