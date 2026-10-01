-- Derive PDF metadata and styling from the Markdown source of truth.
local function typst_inlines(inlines)
  return pandoc.write(pandoc.Pandoc({pandoc.Plain(inlines)}), "typst"):gsub("%s+$", "")
end

local function typst_text(value)
  return typst_inlines({pandoc.Str(value)})
end

function Pandoc(document)
  local blocks = {}
  local summary_pending = false
  for _, block in ipairs(document.blocks) do
    if block.t == "Para" then
      local value = pandoc.utils.stringify(block.content)
      local date, status = value:match("^Stakeholder brief · Date: (.-) · Status: (.+)$")
      if date then
        block = pandoc.RawBlock("typst", "#brief-meta([" .. typst_text(date)
          .. "], [" .. typst_text(status) .. "])")
        summary_pending = true
      elseif summary_pending then
        block = pandoc.RawBlock("typst", "#brief-summary[" .. typst_inlines(block.content) .. "]")
        summary_pending = false
      elseif value:match("^Tracking:") then
        block = pandoc.RawBlock("typst", "#brief-footer[" .. typst_inlines(block.content) .. "]")
      end
    elseif block.t == "Table" and #block.colspecs == 2 then
      block.colspecs = {{pandoc.AlignLeft, 0.38}, {pandoc.AlignLeft, 0.62}}
    end
    table.insert(blocks, block)
  end
  document.blocks = blocks
  return document
end
