'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { useContactsByCompany, useDeleteContact } from '@/hooks/use-contacts'
import { ContactFormDialog } from './contact-form-dialog'
import type { Tables } from '@/types/database'
import { Pencil, Trash2, Plus } from 'lucide-react'

type Props = {
  companyId: string
}

export function ContactsList({ companyId }: Props) {
  const { data: contacts, isLoading } = useContactsByCompany(companyId)
  const deleteMutation = useDeleteContact()

  const [formOpen, setFormOpen] = useState(false)
  const [editingContact, setEditingContact] = useState<Tables<'contacts'> | null>(
    null
  )

  const handleAddClick = () => {
    setEditingContact(null)
    setFormOpen(true)
  }

  const handleEditClick = (contact: Tables<'contacts'>) => {
    setEditingContact(contact)
    setFormOpen(true)
  }

  const handleDeleteClick = async (contact: Tables<'contacts'>) => {
    const fullName = `${contact.last_name}${contact.first_name || ''}`
    if (!window.confirm(`${fullName}さんを削除しますか？`)) {
      return
    }

    try {
      await deleteMutation.mutateAsync(contact.id)
    } catch (error) {
      console.error('Delete contact error:', error)
    }
  }

  if (isLoading) {
    return (
      <div className="flex items-center justify-center p-8">
        <p className="text-muted-foreground">読み込み中...</p>
      </div>
    )
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h3 className="text-lg font-semibold">担当者一覧</h3>
        <Button onClick={handleAddClick} size="sm">
          <Plus className="h-4 w-4 mr-1" />
          担当者を追加
        </Button>
      </div>

      {!contacts || contacts.length === 0 ? (
        <div className="border rounded-lg p-8 text-center text-muted-foreground">
          担当者が登録されていません
        </div>
      ) : (
        <div className="border rounded-lg">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>姓名</TableHead>
                <TableHead>役職</TableHead>
                <TableHead>部署</TableHead>
                <TableHead>電話</TableHead>
                <TableHead>メール</TableHead>
                <TableHead className="text-center">キーパーソン</TableHead>
                <TableHead className="text-right">操作</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {contacts.map((contact) => {
                const fullName = `${contact.last_name}${contact.first_name ? ` ${contact.first_name}` : ''}`

                return (
                  <TableRow key={contact.id}>
                    <TableCell className="font-medium">{fullName}</TableCell>
                    <TableCell>{contact.position || '-'}</TableCell>
                    <TableCell>{contact.department || '-'}</TableCell>
                    <TableCell>
                      {contact.mobile || contact.phone || '-'}
                    </TableCell>
                    <TableCell>
                      {contact.email ? (
                        <a
                          href={`mailto:${contact.email}`}
                          className="text-blue-600 hover:underline"
                        >
                          {contact.email}
                        </a>
                      ) : (
                        '-'
                      )}
                    </TableCell>
                    <TableCell className="text-center">
                      {contact.is_key_person && (
                        <Badge variant="default" className="text-xs">
                          キーパーソン
                        </Badge>
                      )}
                    </TableCell>
                    <TableCell className="text-right">
                      <div className="flex justify-end gap-2">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleEditClick(contact)}
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleDeleteClick(contact)}
                          disabled={deleteMutation.isPending}
                        >
                          <Trash2 className="h-4 w-4 text-red-500" />
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                )
              })}
            </TableBody>
          </Table>
        </div>
      )}

      <ContactFormDialog
        companyId={companyId}
        contact={editingContact}
        open={formOpen}
        onOpenChange={setFormOpen}
      />
    </div>
  )
}
