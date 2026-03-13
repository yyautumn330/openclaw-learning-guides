const http = require('http');

const server = http.createServer((req, res) => {
  console.log('收到请求:', req.method, req.url);
  
  if (req.method === 'POST' && req.url === '/webhook/feishu') {
    let body = '';
    req.on('data', chunk => {
      body += chunk.toString();
    });
    
    req.on('end', () => {
      try {
        const data = JSON.parse(body);
        console.log('收到飞书验证请求:', JSON.stringify(data, null, 2));
        
        // 验证是否是验证请求
        if (data.header && data.header.event_type === 'url_verification' && data.event && data.event.challenge) {
          const response = {
            challenge: data.event.challenge
          };
          
          res.writeHead(200, {
            'Content-Type': 'application/json; charset=utf-8',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type'
          });
          res.end(JSON.stringify(response));
          console.log('已返回验证响应:', JSON.stringify(response, null, 2));
          return;
        }
      } catch (error) {
        console.error('解析请求失败:', error);
      }
      
      // 如果不是验证请求，返回 400
      res.writeHead(400, { 'Content-Type': 'application/json; charset=utf-8' });
      res.end(JSON.stringify({ error: 'Invalid request' }));
    });
  }
  
  // 处理 OPTIONS 请求（CORS）
  if (req.method === 'OPTIONS') {
    res.writeHead(200, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type'
    });
    res.end();
    return;
  }
  
  // 其他请求返回 404
  res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' });
  res.end('Not Found');
});

const PORT = 18790;
// 绑定到所有接口，不只是 127.0.0.1
server.listen(PORT, '0.0.0.0', () => {
  console.log(`飞书验证服务器启动在 http://0.0.0.0:${PORT}`);
  console.log(`Webhook 地址: http://localhost:${PORT}/webhook/feishu`);
});