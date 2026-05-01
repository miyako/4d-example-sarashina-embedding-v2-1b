//%attributes = {"invisible":true}
/*

Srashina Embeddingの場合
"text: "のトークン数を計算に含めて
テキストを分割する必要があります。

*/

TRUNCATE TABLE:C1051([Documents:1])
SET DATABASE PARAMETER:C642([Documents:1]; Table sequence number:K37:31; 0)

var $files : Collection
$files:=Folder:C1567("/RESOURCES/").files(fk ignore invisible:K87:22 | fk recursive:K87:7).query("extension == :1"; ".md")

var $file : 4D:C1709.File
For each ($file; $files)
	var $task : Object
	$task:={file: $file; \
		text_as_tokens: False:C215; \
		tokens_length: 1019; \
		overlap_ratio: 0.09; \
		unique_values_only: True:C214; \
		pooling_mode: Extract Pooling Mode Last}
	var $extracted : Object
	$extracted:=Extract(Extract Document MD; Extract Output Collection; $task)
	If ($extracted.success)
		var $input : Text
		For each ($input; $extracted.input)
			var $document : cs:C1710.DocumentsEntity
			$document:=ds:C1482.Documents.new()
			$document.Text:=$input
			$document.Path:=$file.path
			$document.save()
		End for each 
	End if 
End for each 
