LastDistances := []

ArrayClear(ary) {
	while (ary.Length() > 0) {
		ary.Pop()
	}
}

GetCell() {
	clipboard =
	SendInput, {F2}+{Home}^+c
	ClipWait, 0
	SendInput, {Esc}
	v = %clipboard%
	return v
}

DownOneCell() {
	SendInput, {Down}
}

OverwriteCurrentCell(v) {
	SendInput, {Esc}{Space}%v%{Enter}
}

GetColumn(len) {
	ary := []
	loop % (len - 1) {
		v := GetCell()
		ary.Push(v)
		DownOneCell()
	}
	v := GetCell()
	ary.Push(v)
	return ary
}



#e::
	WriteOdometerCells()	
	return

#z::
	UpdateDistances(1)
	return

#x::
	UpdateDistances(3)
	return

#c::
	UpdateDistances(5)
	return

#v::
	UpdateDistances(10)
	return

WriteOdometerCells() {
	global LastDistances
	odom := Round(GetCell(), 1)
	For i, v in LastDistances {
		odom := Round(odom + v, 1)
		OverwriteCurrentCell(odom)
		DownOneCell()
	}
}

UpdateDistances(n) {
	global LastDistances
	ArrayClear(LastDistances)
	LastDistances.Push(0)
	distances := GetColumn(n)
	For i, v in distances {
		x := StrLen(v) == 0 ? 0 : v
		LastDistances[i + 1] := x
	}
}
		
		
