-- AlterTable
ALTER TABLE `synclog` ADD COLUMN `parentOrderId` VARCHAR(191) NULL;

-- CreateIndex
CREATE INDEX `SyncLog_parentOrderId_idx` ON `SyncLog`(`parentOrderId`);
