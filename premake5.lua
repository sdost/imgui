project "ImGui"
kind "StaticLib"
language "C++"
staticruntime "off"

targetdir("bin/" .. outputdir .. "/%{prj.name}")
objdir("bin-int/" .. outputdir .. "/%{prj.name}")

files
{
  "imconfig.h",
  "imgui.h",
  "imgui.cpp",
  "imgui_draw.cpp",
  "imgui_internal.h",
  "imgui_tables.cpp",
  "imgui_widgets.cpp",
  "imstb_rectpack.h",
  "imstb_textedit.h",
  "imstb_truetype.h",
  "imgui_demo.cpp"
}

filter "system:windows"
systemversion "latest"
cppdialect "C++17"

filter "system:linux"
pic "On"
systemversion "latest"
cppdialect "C++17"

-- SDE-8: vendor code stays optimized in Debug. Symbols stay on so engine
-- callstacks resolve cleanly when stepping through Seidr code that calls into
-- ImGui; we just don't want bounds-checked containers and zero inlining in
-- the per-frame ImGui path.
filter "configurations:Debug"
runtime "Debug"
symbols "on"
optimize "speed"
runtimechecks "Off"  -- /RTC1 conflicts with /O2; SDE-8 prioritizes speed

filter "configurations:Release"
runtime "Release"
optimize "on"

filter "configurations:Dist"
runtime "Release"
optimize "on"
symbols "off"