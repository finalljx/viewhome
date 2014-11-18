jQuery._uuid_default_prefix = '';
jQuery._uuidlet = function() {
	return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}

jQuery.uuid = function(p) {
	if (typeof (p) == 'object' && typeof (p.prefix) == 'string') {
		jQuery._uuid_default_prefix = p.prefix;
	} else {
		p = p || jQuery._uuid_default_prefix || '';
		return (p + jQuery._uuidlet() + jQuery._uuidlet() + "-"
				+ jQuery._uuidlet() + "-" + jQuery._uuidlet() + "-"
				+ jQuery._uuidlet() + "-" + jQuery._uuidlet()
				+ jQuery._uuidlet() + jQuery._uuidlet());
	}
}