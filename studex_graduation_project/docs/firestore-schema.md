# Firestore Schema

This document defines the Firestore collections and fields used by the application. Use these definitions as the authoritative source when implementing repositories and models.

Collections

1) users
- Path: `users/{uid}`
- Description: User profile and metadata.
- Fields:
  - uid: string (document ID, same as Firebase Auth uid)
  - name: string
  - email: string
  - role: string (e.g., "student", "teacher", "admin")
  - avatarUrl: string? (nullable)
  - bio: string? (nullable)
  - createdAt: timestamp
  - updatedAt: timestamp
  - lastSeen: timestamp? (nullable)

Example:
```
users/uid123 {
  name: "Ali",
  email: "ali@example.com",
  role: "student",
  avatarUrl: null,
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

---

2) rooms
- Path: `rooms/{roomId}`
- Description: Classroom/group metadata and membership list.
- Fields:
  - id: string (document ID)
  - name: string
  - description: string? (nullable)
  - ownerId: string (uid of room creator)
  - members: map<string, bool> or array of uids (recommend map for quick membership checks)
  - isPublic: bool
  - createdAt: timestamp
  - updatedAt: timestamp

Example:
```
rooms/roomABC {
  name: "Math 101",
  ownerId: "uid123",
  members: {"uid123": true, "uid456": true},
  isPublic: false,
  createdAt: Timestamp
}
```

---

3) quizzes
- Path: `quizzes/{quizId}`
- Description: Quiz definitions. Questions may be stored as a subcollection `quizzes/{quizId}/questions` or as an embedded array depending on query needs.
- Fields:
  - id: string (document ID)
  - title: string
  - description: string? (nullable)
  - authorId: string (uid)
  - totalMarks: number
  - durationSeconds: number? (nullable)
  - isPublished: bool
  - tags: array<string>
  - createdAt: timestamp
  - updatedAt: timestamp

Optional subcollection: `quizzes/{quizId}/questions` with documents:
  - id: string
  - text: string
  - options: array<string>
  - correctOptionIndex: number
  - marks: number

Example:
```
quizzes/quiz1 {
  title: "Algebra Basics",
  authorId: "uid456",
  totalMarks: 20,
  isPublished: true,
  createdAt: Timestamp
}
```

---

4) quiz_attempts
- Path: `quiz_attempts/{attemptId}` or nested under `users/{uid}/quiz_attempts/{attemptId}` (recommend top-level for analytics, with userId field)
- Description: Stores each attempt of a quiz by a user.
- Fields:
  - id: string (document ID)
  - quizId: string
  - userId: string
  - startedAt: timestamp
  - finishedAt: timestamp? (nullable)
  - score: number
  - totalCorrect: number
  - totalQuestions: number
  - durationSeconds: number? (nullable)
  - answers: map<string, dynamic> or array of answer objects (questionId -> answer)
  - createdAt: timestamp

Example:
```
quiz_attempts/att1 {
  quizId: "quiz1",
  userId: "uid123",
  startedAt: Timestamp,
  finishedAt: Timestamp,
  score: 18,
  totalQuestions: 20,
  answers: {"q1": "A", "q2": "C"}
}
```

---

5) notifications
- Path: `notifications/{notificationId}` or `users/{uid}/notifications/{notificationId}` (recommend per-user subcollection for access control)
- Description: Notifications targeted to users.
- Fields:
  - id: string (document ID)
  - userId: string (recipient uid)
  - type: string (e.g., "quiz_result", "invitation")
  - title: string
  - body: string
  - data: map<string, dynamic> (optional payload)
  - read: bool
  - createdAt: timestamp

Example:
```
users/uid123/notifications/n1 {
  type: "quiz_result",
  title: "Your quiz results are ready",
  body: "You scored 18/20",
  read: false,
  createdAt: Timestamp
}
```

---

Indexes and Security Notes

- Create composite indexes where queries combine fields (e.g., quizzes by authorId and isPublished).
- Prefer storing frequently queried relational fields on the parent document (denormalization) to reduce reads.
- Security rules should enforce that users can only read/write their own user document and their notifications. Room membership checks should be enforced server-side or via security rules that verify membership maps.

Revision history

- v1 — Initial schema (authoritative after team review).
