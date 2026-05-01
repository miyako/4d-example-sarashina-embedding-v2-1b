//%attributes = {}
/*

Srashina Embeddingの場合
text: 
でレコードを作成する必要があります。

*/

var $documents : cs:C1710.DocumentsSelection
$documents:=ds:C1482.Documents.all()

var $AIClient : cs:C1710.AIKit.OpenAI
$AIClient:=cs:C1710.AIKit.OpenAI.new()
$AIClient.baseURL:="http://127.0.0.1:8080/v1"

var $batch : cs:C1710.AIKit.OpenAIEmbeddingsResult
var $document : cs:C1710.DocumentsEntity
For each ($document; $documents)
	$batch:=$AIClient.embeddings.create("text: "+$document.Text)
	If ($batch.success)
		$document.Embeddings:=$batch.embedding.embedding
		$document.save()
	Else 
		TRACE:C157
	End if 
End for each 