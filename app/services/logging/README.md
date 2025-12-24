# Logging Services

Servicios para registro de operaciones y webhooks.

## Archivos

### `sync-logger.server.ts`
Maneja los logs de sincronización en la tabla `SyncLog`.

**Exports:**
- `createSyncLog()` - Crea un registro genérico de sync
- `logCustomerSync()` - Registra sincronización de customer
- `logProductSync()` - Registra sincronización de producto
- `logDealSync()` - Registra sincronización de deal
- `logOrderSync()` - Registra sincronización de orden completa
- `logSyncError()` - Registra un error de sincronización
- `getRecentSyncLogs()` - Obtiene logs recientes (con paginación)
- `getSyncLogsByType()` - Filtra logs por tipo
- `getSyncStats()` - Estadísticas de sincronizaciones

**Modelo SyncLog:**
- `shopId` - Tienda asociada
- `syncType` - CUSTOMER | PRODUCT | DEAL | ORDER
- `shopifyId` - ID del objeto en Shopify
- `clientifyId` - ID del objeto en Clientify
- `status` - SUCCESS | ERROR
- `errorMessage` - Mensaje de error (si aplica)
- `requestData` - Datos enviados a Clientify (JSON)
- `responseData` - Respuesta de Clientify (JSON)

### `webhook-logger.server.ts`
Maneja los logs de webhooks en la tabla `WebhookLog`.

**Exports:**
- `createWebhookLog()` - Registra un webhook recibido
- `markWebhookAsProcessed()` - Marca webhook como procesado exitosamente
- `markWebhookAsError()` - Marca webhook con error
- `getRecentWebhooks()` - Obtiene webhooks recientes (con paginación)
- `getWebhooksByTopic()` - Filtra por topic
- `getUnprocessedWebhooks()` - Webhooks pendientes de procesar
- `getWebhookStats()` - Estadísticas de webhooks

**Modelo WebhookLog:**
- `shopId` - Tienda asociada
- `topic` - orders/create, orders/updated, etc.
- `shopifyId` - ID del objeto en Shopify
- `headers` - Headers HTTP del webhook (JSON)
- `payload` - Body del webhook (JSON)
- `hmacValid` - Si el HMAC fue validado
- `processed` - Si se procesó correctamente
- `errorMessage` - Mensaje de error (si aplica)

## Uso

```typescript
// En un webhook
const webhookLog = await createWebhookLog({...});
try {
  await syncOrder();
  await markWebhookAsProcessed(webhookLog.id);
} catch (error) {
  await markWebhookAsError(webhookLog.id, error.message);
}
```
