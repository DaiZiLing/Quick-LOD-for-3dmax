--单个物体设置LOD
rollout AutoLOD "AutoLODTool" width:251 height:207
(
	button 'btn1' "复制" pos:[6,6] width:55 height:25 align:#left
	button 'btn2' "命名" pos:[65,6] width:55 height:25 align:#left
	button 'btn3' "优化" pos:[125,6] width:55 height:25 align:#left
	button 'btn4' "对齐成组" pos:[185,6] width:55 height:25 align:#left
	spinner 'spn1' "" pos:[178,69] width:40 height:16 range:[0,100,50] type:#integer align:#left
	spinner 'spn2' "" pos:[178,88] width:40 height:16 range:[0,100,25] type:#integer align:#left
	spinner 'spn3' "" pos:[178,107] width:40 height:16 range:[0,100,13] type:#integer align:#left
	spinner 'spn4' "" pos:[180,183] width:45 height:16 range:[0,180,1] type:#float scale:0.1 align:#left
	spinner 'spn5' "" pos:[180,164] width:45 height:16 range:[0,99999,0] type:#float scale:0.1 align:#left
	label 'LOD1_Name' "LOD1" pos:[10,73] width:29 height:15 align:#left
	label 'LOD2_Name' "LOD2" pos:[10,91] width:29 height:15 align:#left
	label 'LOD3_Name' "LOD3" pos:[10,109] width:29 height:15 align:#left
	label 'lbl4' "合并点阈值" pos:[114,166] width:60 height:15 align:#left
	label 'lbl5' "合并面阈值" pos:[114,183] width:60 height:15 align:#left

	checkbox 'chk1' "保持纹理" pos:[8,182] width:67 height:17 checked:true align:#left
	
	dropdownList 'ddl1' "优化模式" pos:[9,137] width:84 height:41 items:#("保护边界", "压碎边界", "排除边界") align:#left
	
	label 'LOD0_Name' "LOD0" pos:[10,55] width:29 height:15 align:#left
	label 'Ima_Tris' "当前面数" pos:[98,37] width:51 height:12 align:#left
	label 'lbl49' "优化百分比" pos:[179,37] width:64 height:12 align:#left
	label 'LOD_Level' "LOD级别" pos:[10,38] width:78 height:15 align:#left
	
	label 'LOD0_Tris' "N/A" pos:[99,56] width:55 height:12 align:#left
	label 'LOD1_Tris' "N/A" pos:[99,74] width:55 height:12 align:#left
	label 'LOD2_Tris' "N/A" pos:[99,91] width:55 height:12 align:#left
	label 'LOD3_Tris' "N/A" pos:[99,108] width:55 height:12 align:#left
	
	label 'lbl113' "-→" pos:[69,56] width:25 height:12 align:#left
	label 'lbl114' "-→" pos:[69,73] width:25 height:12 align:#left
	label 'lbl115' "-→" pos:[69,91] width:25 height:12 align:#left
	label 'lbl116' "-→" pos:[69,107] width:25 height:12 align:#left
	label 'lbl117' "-→" pos:[153,56] width:25 height:12 align:#left
	label 'lbl118' "-→" pos:[153,73] width:23 height:12 align:#left
	label 'lbl119' "-→" pos:[153,91] width:23 height:12 align:#left
	label 'lbl120' "-→" pos:[153,107] width:23 height:12 align:#left
	label 'lbl48' "———————————————————" pos:[10,124] width:232 height:12 align:#left
	label 'lbl50' "%" pos:[224,73] width:13 height:12 align:#left
	label 'lbl52' "%" pos:[224,110] width:13 height:12 align:#left
	label 'lbl55' "%" pos:[224,91] width:13 height:12 align:#left
	label 'lbl53' "100   %" pos:[188,55] width:56 height:11 align:#left
	
	global LOD1_VAR1 = 50
	global LOD2_VAR2 = 25
	global LOD3_VAR3 = 13
	global FacesAngle = 1
	global VertexAngle = 0
	
	global benti
	global nnl
	global nnl2
	global nnl3
	global zancun
	
	-- End of Button Brace --
	
	on btn1 pressed do --复制
	(
		MAX select all
		LOD0_Tris.text = $.faces.count as string
		
		benti = for o in $ collect o --这是本体
		
		juli = ( $.max.y - $.min.y ) * 1.1
		maxOps.cloneNodes $ cloneType:#copy newNodes:&nnl
		select nnl --这是LOD1
		LOD1_Tris.text = $.faces.count as string
		
		move $ [0, -1 * juli, 0]
		
		maxOps.cloneNodes $ cloneType:#copy newNodes:&nnl2
		select nnl2 --这是LOD2
		LOD2_Tris.text = $.faces.count as string
		move $ [0, -1 * juli, 0]
		
		maxOps.cloneNodes $ cloneType:#copy newNodes:&nnl3
		select nnl3 --这是LOD3
		LOD3_Tris.text = $.faces.count as string
		move $ [0, -1 * juli, 0]
		
		clearSelection()
		
		
		
	)
	on btn2 pressed do --命名
	(
		zancun = benti[1].name
		benti[1].name = benti[1].name + "_LOD0"
		
		select nnl
		$.name = zancun as string + "_LOD1"
		LOD1_Tris.text = $.faces.count as string
		
		select nnl2
		$.name = zancun as string + "_LOD2"
		LOD2_Tris.text = $.faces.count as string
		
		select nnl3
		$.name = zancun as string + "_LOD3"
		LOD3_Tris.text = $.faces.count as string
		
		clearSelection()
	)
	on btn3 pressed do --优化
	(
		select nnl
		modPanel.addModToSelection (ProOptimizer ()) ui:on
			
			if chk1.checked do
			(
				$.modifiers[#ProOptimizer].KeepUV = on
			)
		
		$.modifiers[#ProOptimizer].MergePointsThreshold = VertexAngle
		$.modifiers[#ProOptimizer].MergeFacesAngle = FacesAngle
		$.modifiers[#ProOptimizer].VertexPercent = LOD1_VAR1
		$.modifiers[#ProOptimizer].OptimizationMode = 1
		
		$.modifiers[#ProOptimizer].Calculate = on
		LOD1_Tris.text = $.faces.count as string
		
		clearSelection()
		
		-------------------------------------
		
		select nnl2
		modPanel.addModToSelection (ProOptimizer ())
			
		if chk1.checked do
			(
				$.modifiers[#ProOptimizer].KeepUV = on
			)
	
		$.modifiers[#ProOptimizer].MergePointsThreshold = VertexAngle
		$.modifiers[#ProOptimizer].MergeFacesAngle = FacesAngle
		$.modifiers[#ProOptimizer].VertexPercent = LOD2_VAR2
		$.modifiers[#ProOptimizer].OptimizationMode = 1
		
		$.modifiers[#ProOptimizer].Calculate = on
		LOD2_Tris.text = $.faces.count as string
		
		clearSelection()
		
		-------------------------------------
		
		select nnl3
		modPanel.addModToSelection (ProOptimizer ())
			
		if chk1.checked do
			(
				$.modifiers[#ProOptimizer].KeepUV = on
			)
		
		$.modifiers[#ProOptimizer].MergePointsThreshold = VertexAngle
		$.modifiers[#ProOptimizer].MergeFacesAngle = FacesAngle
		$.modifiers[#ProOptimizer].VertexPercent = LOD3_VAR3
		$.modifiers[#ProOptimizer].OptimizationMode = 1
		
		$.modifiers[#ProOptimizer].Calculate = on
		LOD3_Tris.text = $.faces.count as string
		
		clearSelection()
		
		clearUndoBuffer() 
		freeSceneBitmaps() 
		
		-------------------------------------
		
	)
	on btn4 pressed do --对齐成组
	(
		benti[1].pos
		
		select nnl
		$.pos = benti[1].pos
		
		select nnl2
		nnl2.pos = benti[1].pos
		
		select nnl3
		nnl3.pos = benti[1].pos
		
		clearSelection()
		
		select benti[1]
		selectmore nnl
		selectmore nnl2
		selectmore nnl3
		
		group $ name: zancun as string
	
	)
	on spn1 changed var do
	(
		LOD1_VAR1 = var
	)
	on spn2 changed var do
	(
		LOD2_VAR2 = var
	)
	on spn3 changed var do
	(
		LOD3_VAR3 = var
	)
	on spn4 changed var do
	(
		FacesAngle = var
	)
	on spn5 changed var do
	(
		VertexAngle = var
	)
)



-- End of Rollout --
createDialog AutoLOD
gc()
clearlistener()
	