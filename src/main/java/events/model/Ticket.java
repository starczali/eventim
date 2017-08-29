package events.model;

import javax.validation.constraints.NotNull;

public class Ticket {
    private Integer id;
    @NotNull
    private User user;
    @NotNull
    private Event event;
    private Long barcode;

    public Ticket() {
    }

    public Ticket(Integer id, User user, Event event, Long barcode, Double price) {
        this.id = id;
        this.user = user;
        this.event = event;
        this.barcode = barcode;
    }

    @Override
    public String toString() {
        return "Ticket{" +
                "id=" + id +
                ", user=" + user +
                ", event=" + event +
                ", barcode=" + barcode +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public Long getBarcode() {
        return barcode;
    }

    public void setBarcode(Long barcode) {
        this.barcode = barcode;
    }
    @Override
    @SuppressWarnings("all")
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Ticket ticket = (Ticket) o;

        if (id != null ? !id.equals(ticket.id) : ticket.id != null) return false;
        if (user != null ? !user.equals(ticket.user) : ticket.user != null) return false;
        if (event != null ? !event.equals(ticket.event) : ticket.event != null) return false;
        return barcode != null ? !barcode.equals(ticket.barcode) : ticket.barcode == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + (event != null ? event.hashCode() : 0);
        result = 31 * result + (barcode != null ? barcode.hashCode() : 0);
        return result;
    }
}
