-- Keep the rendered proposal aligned with its Markdown source and directory.
function Header(element)
  local title = pandoc.utils.stringify(element.content)
  if (element.level == 1 and title == "RHOAI API Contract Working Group")
    or (element.level == 2 and title == "Pilot Architecture and Delivery Proposal") then
    return {}
  end
end

function Link(element)
  if not element.target:match("^%a[%w+.-]*:")
    and not element.target:match("^[#/]") then
    element.target = "../" .. element.target
  end
  return element
end

function RawBlock(element)
  if element.format == "html" then
    element.text = element.text:gsub('src="architecture%-flow%.svg"',
      'src="../architecture-flow.svg"')
  end
  return element
end
