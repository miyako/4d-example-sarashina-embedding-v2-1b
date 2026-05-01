# 4d-example-sarashina-embedding-v2-1b
Sarashina Embedding in GGUF

```4d
var $AIClient : cs.AIKit.OpenAI
$AIClient:=cs.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8080/v1"  // llama-server

$query:=\
"task: クエリを与えるので、与えられたWeb検索クエリに答える関連文章を検索してください。\n"\
+\
"query: 4D Serverが使用するTCPポート番号を教えて?"

var $batch : cs.AIKit.OpenAIEmbeddingsResult
$batch:=$AIClient.embeddings.create($query)

If ($batch.success)
	$vector:=$batch.embedding.embedding
	var $comparison:={vector: $vector; metric: mk cosine; threshold: 0.7}
	var $results:=ds.Documents.query("Embeddings > :1"; $comparison)
	If ($results.length#0)
		ALERT($results.first().Text)
	End if 
End if
```
