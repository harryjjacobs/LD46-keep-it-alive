local bounds = {}

function bounds:isPointWithinBoundingBox(box, tx, ty)
	return	(box[2].x >= tx and box[2].y >= ty)
		and (box[1].x <= tx and box[1].y <= ty)
		or  (box[1].x >= tx and box[2].y >= ty)
		and (box[2].x <= tx and box[1].y <= ty)
end

return bounds