import { Controller } from "@hotwired/stimulus"
import Sortable from "stimulus-sortable"
// Connects to data-controller="lesson"
export default class extends Sortable {
  static value={course:Number}

  update(event){
    supper.update(event)
    const newIndex=event.newIndex
    const id=event.Item.id
    const courseId=this.courseValue
    fetch('/admin/courses/${courseId}/lessons/${id}/move',{
      method:"PATCH",
      headers:{
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({position: newIndex, id: id})
    })
  }
}
