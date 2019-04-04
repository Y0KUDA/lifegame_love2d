function new_cellAM(width,height)
  local ret={}
  ret.width=width
  ret.height=height
  ret.cells_count=width*height
  local cells={}
  local cells_next={}
  local dummy_cell --for accessing out of area

  function ret.new_cell() --create a cell
    local ret={}
    ret.status=0
    return ret
  end

  function ret.new_cells() -- format cells tables
    for i=1,ret.cells_count do
      cells[i]=ret.new_cell()
      cells_next[i]=ret.new_cell()
    end
    dummy_cell=ret.new_cell()
  end

  function ret.access_cell(x,y)
    if x<1 or x>width or y<1 or y>height then return dummy_cell end
    return cells[width*(y-1)+x]
  end

  function ret.access_cell_next(x,y)
    if x<0 or x>width or y<0 or y>height then return dummy_cell end
    return cells_next[width*(y-1)+x]
  end

  function ret.next_age(f)
    local x,y
    for x=1,width do
      for y=1,height do
        ret.access_cell_next(x,y).status=f(x,y)
      end
    end
    tmp=cells
    cells=cells_next
    cells_next=tmp
  end

  function ret.show(f) --f(status ,x,y)
    for y=1,height do
      for x=1,width do
        f(ret.access_cell(x,y).status,x,y)
      end
    end
  end

  return ret
end
