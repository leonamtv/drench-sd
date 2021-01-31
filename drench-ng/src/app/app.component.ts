import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {

  public size : number = 14
  public limit : number = 30

  public _matrix : number[][]
  public classes : string[]
  public over : boolean
  public counter : number

  constructor() {
    this.over = false
    this.counter = 0
    this.classes = [
      'green', 'pink', 'purple', 'blue', 'red', 'yellow'
    ]
    this._matrix = []    
    for ( let i = 0; i < this.size; i++ ) {
      this._matrix[i] = []
      for ( let j = 0; j < this.size; j++ ) {
        this._matrix[i][j] = Math.floor(Math.random() * 6)  
      }
    }
  }

  getClass ( cell : any ) {
    return this.classes [ parseInt(cell) ]
  }

  verificaGameOver() {
    if ( this.counter == this.limit ) return true
    let val : number = this._matrix[0][0]
    let cont : number = 0
    for ( let i = 0; i < this.size; i++ ) {
      for ( let j = 0; j < this.size; j++ ) {
        if ( this._matrix[i][j] != val ) return false
      }
      cont ++ 
    }
    return cont == ( this.size * this.size )
  }

  updateCanvas ( value : number ) {
    if ( this.over ) return
    if ( value == this._matrix[0][0] ) return
    this.counter++
    this.updateMatrix ( value, this._matrix[0][0] )
    if ( this.verificaGameOver()) {
      this.over = true
      return
    }
  }

  updateMatrix ( value : number, oldValue : number, x : number = 0, y : number = 0 ) {
    if ( x >= this.size || y >= this.size || x < 0 || y < 0 ) 
      return
    if(this._matrix[x][y] != oldValue && (x != 0 || y != 0))
      return  
    this._matrix[x][y] = value;
    this.updateMatrix ( value, oldValue, x, y + 1 );
    this.updateMatrix ( value, oldValue, x, y - 1 );
    this.updateMatrix ( value, oldValue, x + 1, y );
    this.updateMatrix ( value, oldValue, x - 1, y );
  }

}
